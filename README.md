# This is a note for my Arch linux.

-------------------------------------

## Installation

### PC
MSI GE60 2OE

CPU: i7-4700

GPU: GTX 765M

Windows8 preinstalled.


### Preparation

Download the image from here.

https://www.archlinux.org/download/

And create an Arch linux installer USB drvie with dd command on a mac.
```sh
dd if=image.iso of=/dev/rdisk2 bs=1m
```

for other method in different platform, you may refer the arch wiki.

https://wiki.archlinux.org/index.php/USB_flash_installation_media


### Boot

Note that you may need to disable secure boot.

### Archiso shell

Connect to the internet.

Wireless.

```sh
wifi-menu -o wlp5s0
```

Update the system clock.

```sh
timedatectl set-ntp true
```

### Partition the disk

Identify the divces.

```sh
lsblk
```
Use cgdsik to partition.

```sh
cgdisk /dev/sdx
```

Format filesystem and mount it on /mnt.

```sh
mkfs.ext4 /dev/sdxx
mount /dev/sdxx /mnt
```

Select the best mirror and install the base package.

```sh
vim /etc/pacman.d/mirrorlist
pacstrap -i /mnt base base-devel
```
Mount the efi partition.

```sh
mkdir -p /mnt/boot/efi
mount /dev/sdxx /mnt/boot/efi
```

### Configuration

Generate fstab.

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Chroot into arch isntallation

```sh
arch-chroot /mnt
```

Some configuration.

```sh
passwd
echo HOSTNAME >> /ect/hostname
tzselect
ln -s /usr/share/zoneinfo/ZONE/SUBZONE /etc/localtime
vi /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
hwclock --systohc --utc
mkinitcpio -p linux
```

Network

```sh
pacman -S iw wpa_supplicant dialog networkmanager
systemctl enable NetworkManager
```
Grub

```sh
pacman -S grub efibootmgr
grub-mkconfig -o /boot/grub/grub.cfg
grub-install /dev/sdX
```

Desktop

```sh
pacman -S zsh vim guake gnome network-manager-applet 
useradd -m -g users -G wheel -s /bin/zsh USERNAME 
passwd USERNAME
pacman -S gdm
systemctl enable gdm
```

Unmount and reboot

```sh
exit
umount 	-R /mnt
reboot
```

### Configure windows boot manager after reboot

```sh
nmcli dev wifi connect WIFISSID password WIFIPASSWROD
su
visudo 
pacman -S os-prober
grub-mkconfig -o /boot/grub/grub.cfg
reboot
```
---------------------------------------

## Cusomization

```sh
sudo pacman -Syyu
sudo pacman -S wget chromium git mpv cmus gnome-tweak-tool zip unrar
sudo pacman -S python python2 
sudo pacman -S wqy-bitmapfont wqy-zenhei ttf-arphic-ukai ttf-arphic-uming opendesktop-fonts
```


## SSH

```sh
sudo pacman -S openssh
sudo systemctl enable sshd.socket
sudo systemctl start sshd.socket
sudo vi /etc/ssh/sshd_config
```
## Touchpad

```sh
sudo pacman -S xf86-input-synaptics xf86-input-libinput
synclietn TouchpadOff=1
```

## yaourt

```sh
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https//aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
```

## Move the home

```sh
mkdir /home.new
mount /dev/sdX /home.new
cp -a /home/user /home.new
umout /home.new
rm -rf /home
mv /home.new /home
mount /dev/sdX /home
lsblk -f
vim /etc/fstab
```

## CCache

```sh
sudo pacman -S ccache
echo 'export PATH="/usr/lib/ccache/bin/:$PATH" >> ~/.zshrc'
sudo vim /etc/makepkg.conf
```
In BUILDDEV uncomment cache.



## Console fonts

```sh
yaourt -S terminess-powerline-font-git
setfonts /usr/share/kbd/ter-powerline-v32n.psf.gz
vim /etc/vconsole.conf 
```
then set FONT=ter-powerline-v32n.


## Setup terminal

```sh
echo export TERM=xterm-256color >> ~/.zshrc
```

## Arduino

```sh
yaourt -S arduino
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER lock
```

## Misc

```sh
sudo pacman -S zip ntfs-3g
yaourt -S insync
sudo systemctl enable insync@<user>
```

## Net monitor

```sh
sudo pacman -S nmap wireshark netcat iptraf
```


## Matlab

Download the installer

```sh
ln -s /{MATLAB}/bin/matlab /usr/local/bin}
gpg --recv-keys F7E48EDB
yaourt -S ncurses5-compat-libs
./$MATLABROOT/bin/activate_matlab.sh
```

## VirtualBox

```sh
sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso qt4 
yaourt -S virtualbox-ext-oracle
sudo systemctl start systemd-modules-load.service
sudo modprobe vboxdrv
sudo gpasswd -a $USER vboxusers
```

## VirtualBox command line

```sh
vboxmanage list vms
vboxmanage list running vms
```



## Nvidia (got some problem)

```sh
pacman -S intel-dri xf86-video-intel nvidia bbswitch bumblebee lib32-nvidia-utils lib32-intel-dri
sudo gpasswd -a $USER bumblebee
sudo systemctl enable bumblebeed
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet rcutree.rcu_idle_gp_delay=1"/' /etc/default/grub
```

Edit /etc/bumblebee/xorg.conf.nvidia, set BusID "PCI:x:x:x", 
which should be the one shown for the Nvidia card in lspci.


To turn on Nvidia graphics card.

```sh
sudo tee /proc/acpi/bbswitch <<< ON
sudo modprobe nvidia
```

To turn off Nvidia graphics card.

```sh
sudo modprobe -r nvidia
sudo tee /proc/acpi/bbswtich <<< OFF
```

Test Bumblebee.

```sh
optirun glxgears -info
```


## Git ssh

```sh
ssh-keygen -t rsa -b 4096 -C <user_email>
ssh-add ~/.ssh/id_rsa
sudo pacman -S xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
```

Then go ssh settings to add the ssh key.

Change https to ssh.

```sh
git remote show origin
git remote set-url origin git+ssh://git@github.com/USERNAME/REPONAME.git
```

## Create git repo in command line

Replace the USER with username and REPO with repository name

```sh
mkdir REPO && cd REPO
git init
echo init > README.md
git add .
git commit -m "init"
curl -u 'USER' https://api.github.com/user/repos -d '{"name":"REPO"}'
git remote add origin https://github.com/USER/REPO.git
# If prefer ssh to https, replace it with the following commad. 
# git remote add origin git@github.com:USER/REPO.git 
git push --set-upstream origin master
```

## curl with bitbucket api

```sh
curl -u USERNAME https://api.bitbucket.org/1.0/repositories --data name=REPO_NAME is_priviate='true'
```

## Gitbook

```sh
sudo npm install gitbook gitbook-cli -g
gitbook init
gitbook serve
```

## Dictionary

```sh
sudo pacman -S sdcv
wget http://abloz.com/huzheng/stardict-dic/zh_TW/stardict-langdao-ec-big5-2.4.2.tar.bz2
wget http://abloz.com/huzheng/stardict-dic/zh_TW/stardict-langdao-ce-big5-2.4.2.tar.bz2
mkdir -p ~/.stardict/dic
tar -xvf stardict-langdao-ec-big5-2.4.2.tar.bz2 /usr/share/stardict/dic -C ~/.stardict/dic
tar -xvf stardict-langdao-ce-big5-2.4.2.tar.bz2 /usr/share/stardict/dic -C ~/.stardict/dic
sdcv -l
```


## PTT

```sh
pacman -S xorg-luit
luit -encoding big5 ssh bbs@ptt.cc
```

## Youtube player hotkeys

Note that I use chromium and cVim plugin, 
so you may not need Alt key in other case.

| Function              | Key       |
|:---------------------:|:---------:|
| Full screen           | \<alt\> F |
| toggle play/pause     | \<alt\> k |
| go forward            | \<alt\> l |
| go back               | \<alt\> j |
| move forward 1 frame  | \<alt\> . |
| move backward 1 frame | \<alt\> , |
| increase speed        | \<alt\> > |
| decrease speed        | \<alt\> < |



## Gnome screenshot Usage

Take screenshot and save to clipboard, of which the hotkey is <Ctrl> + <Shift> + <Ptr Scr>.

```sh
gnome-screenshot -ac
```

Launch a interactive window to take screenshot.

```sh
gnome-screenshot -ai
```

Use xclip command to save the screenshot in command line.

```sh
xclip -se c -t image/png -o > THE_DESTENATION
```

## ZSH plugin

```sh
yaourt -S zsh-syntax-highlighting
youart -S zsh-autosuggestions
echo source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
echo source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
```

## Convert PPT to PDF by LibreOffice

```sh
libreoffice --convert-to pdf FILE_NAME.ptt
```

## Remove files except specific file

```sh
ls | grep -v FILE_NAME | xargs rm
```
## Bug: if encountered unable to open display ":0.0" when open gparted, try 

```sh
export DISPLAY=":0.0"
xhost +
sudo gparted
```


## Use netcat for file transfers

On the receiving end

```sh
nc -l -p PORT > OUTFILE
```

On the sending end

```sh
nc -w 3 DESTINATION PORT < FILE_TO_TRANSFER
```

## monitor the dd progress with pv

```sh
dd if=INFILE | pv | dd of=OUTFILE
```


## Backup

backup pacman database

```sh
tar -cjf pacman_database.tar.bz2 /var/lib/pacman/local
tar -xjvf pacman_database.tar.bz2
```

list native, explicitly installed packages

```sh
pacman -Qqen > pkglist.txt
```

list foreign, explicitly installed packages

```sh
pacman -Qem
```

exclude the foreign packages(ex. AUR)

```sh
comm -12 <(pacman -Slq | sort) <(sort pkglist.txt)
```

install packages from list

```sh
pacman -S - < pkglist
```



















## Shell Script Note

### Change the file extension from .a.b to .b

```sh
for file in *.b; do   
echo  ${file%.a.b}.b    
done
```

### Use ls + grep + xargs + COMMAND to edit file.

```sh
ls | grep 'PATTERN' | xargs -d '\n' -I {} COMMAND {}
```

### wget files in list

```sh
xargs -n 1 wget < filei-urls
```

### Use python to decode/encode url

/usr/local/bin/urlencode

```python
#!/usr/bin/env python
import sys, urllib.parse as up 
print(up.quote_plus(sys.argv[1]))
```

/usr/local/bin/urldecode

```python
#!/usr/bin/env python
import sys, urllib.parse as up 
print(up.unquote_plus(sys.argv[1]))
```

### use rsync to copy 

```sh
rsync -ahP SOURCE DESTINATION
```

### cp with pv to monitor progress

```sh
pv FILE > DESTINATION
```


## Vim-note

Write file with super user privilege

```sh
:w !sudo tee %
```

vim markdown

```sh
TableFormat # format the markdown table
Toc # create a quickfix vertial window of contents of the markdown file
```



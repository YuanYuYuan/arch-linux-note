# This is a tutorial for arch installaion.

## PC
MSI GE60 2OE

CPU: i7-4700

GPU: GTX 765M

Windows8 preinstalled.


## Preparation

Download the image from here.

https://www.archlinux.org/download/

And create an Arch linux installer USB drvie with dd command on a mac.
```sh
dd if=image.iso of=/dev/rdisk2 bs=1m
```

for other method in different platform, you may refer the arch wiki.

https://wiki.archlinux.org/index.php/USB_flash_installation_media


## Boot

Note that you may need to disable secure boot.

## Archiso shell

Connect to the internet.

Wireless.

```sh
wifi-menu -o wlp5s0
```

Update the system clock.

```sh
timedatectl set-ntp true
```

## Partition the disk

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

## Configuration

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

## Configure windows boot manager after reboot

```sh
nmcli dev wifi connect WIFISSID password WIFIPASSWROD
su
visudo 
pacman -S os-prober
grub-mkconfig -o /boot/grub/grub.cfg
reboot
```

## Cusomization

```sh
sudo pacman -Syyu
sudo pacman -S wget chromium git mpv cmus gnome-tweak-tool zip unrar
sudo pacman -S ccache python python2 
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






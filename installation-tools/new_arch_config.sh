echo -e "\n>> Install git & zsh"
sudo pacman -S git zsh --noconfirm

echo -e "\n>> Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "\n>> Install yaourt"
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si --noconfirm
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si --noconfirm
cd ~

echo -e "\n>> Install packages"
for pkg in $(cat pkg_list.txt); do
    yaourt -S $pkg --noconfirm
done

echo -e "\n>> Enable gdm services"
sudo systemctl enable gdm

echo -e "\n>> Virtualbox"
sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso qt4 --noconfirm
yaourt -S virtualbox-ext-oracle --noconfirm
sudo systemctl start systemd-modules-load.service
sudo modprobe vboxdrv
sudo gpasswd -a $USER vboxusers

echo -e "\n>> Setup fonts"
sudo pacman -S wqy-bitmapfont wqy-microhei wqy-zenhei --noconfirm
yaourt -S terminess-powerline-font-git --noconfirm
yaourt -S powerline-fonts-git --noconfirm
sudo setfont /usr/share/kbd/consolefonts/ter-powerline-v32n.psf.gz
sudo touch /etc/vconsole.conf
sudo sh -c "echo FONT=ter-powerline-v32n >> /etc/vconsole.conf"

echo -e "\n >> CCache setup"
sudo pacman -S ccache --noconfirm
echo ">> Remove the exclamation mark to enable ccache"
echo ">> Press enter to edit /etc/makepkg.conf"
read
sudo vim /etc/makepkg.conf

echo -e "\n>> Setup Arduino"
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER lock

echo -e "\n>> Dictionary"
tar xjvf stardict.tar.bz2 
mv .stardict ~/


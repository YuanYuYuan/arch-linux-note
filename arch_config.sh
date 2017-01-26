echo -e "\n>> Install some packages ... "
sudo pacman -S zsh vim neovim zip unrar wget git ntfs-3g thunderbird chromium --noconfirm
sudo pacman -S python python2 bpython bpython2 octave nodejs npm mps-youtube --noconfirm
sudo pacman -S acpi acpid alsa-utils dhcp elinks gnuplot ibus ibus-chewing mpv --noconfirm
sudo pacman -S tree surfraw cmus ranger screen xclip youtube-dl mupdf ncdu tig --noconfirm

echo -e "\n>> Configure zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv .zshrc ~/.zshrc

echo -e "\n>> Setup X window and gnome"
sudo pacman -S xorg xorg-luit gnome gdm gnome-tweak-tool network-manager-applet --noconfirm
sudo systemctl enable gdm


echo -e "\n >> Setup yaourt"
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si --noconfirm
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si --noconfirm

echo -e "\n>> Some AUR packages"
yaourt -S llpp megatools cheat-git --noconfirm

echo -e "\n >> CCache setup"
sudo pacman -S ccache --noconfirm
echo ">> Remove the exclamation mark to enable ccache"
echo ">> Press enter to edit /etc/makepkg.conf"
read
sudo vim /etc/makepkg.conf

echo -e "\n>> Setup fonts"
sudo pacman -S powerline-fonts wqy-bitmapfont wqy-microhei wqy-zenhei --noconfirm
yaourt -S terminess-powerline-font-git --noconfirm
sudo setfont /usr/share/kbd/ter-powerline-v32n.psf.gz
sudo touch /etc/vconsole.conf
sudo -s 'echo "FONT=ter-powerline-v32n" >> /etc/vconsole.conf'
# yaourt -S ttf-google-fonts-git --noconfirm

echo -e "\n>> Setup Arduino"
yaourt -S arduino --noconfirm
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER lock

echo -e "\n>> Cloud drive"
yaourt -S insync dropbox --noconfirm


echo -e "\n>> Net monitor"
sudo pacman -S nmap netcat iptraf speedtest-cli --noconfirm

# echo -e "\n>> untar .config"
# tar xjvf config.tar.bz2


echo -e "\n>> Virtualbox"
sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso qt4 --noconfirm
yaourt -S virtualbox-ext-oracle --noconfirm
sudo systemctl start systemd-modules-load.service
sudo modprobe vboxdrv
sudo gpasswd -a $USER vboxusers


# echo -e "\n>> Dictionary"
# sudo pacman -S sdcv --noconfirm
# tar xjvf stardict.tar.bz2 
# yaourt -S translate-shell --noconfirm


echo -e "\n>> ZSH plugin"
yaourt -S zsh-syntax-highlighting zsh-autosuggestions --noconfirm



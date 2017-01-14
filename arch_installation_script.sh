echo "Set ntp"
timedatectl set-ntp true

echo
echo -n "Enter the device (ex. /dev/sdx)to parted > "
read device
parted $device mklabel gpt
parted $device mkpart ESP fat32 1M 513M
parted $device set 1 boot on
parted $device primary ext4 513M 100%
parted $device print

echo "Format filesystem"
mkfs.fat {$device}1
mkfs.ext4 {$device}2

echo "Mount root and boot/efi"
mount {$device}1 /mnt
mkdir -p /mnt/boot/efi
mount {$device}2 /mnt/boot/efi



echo "Use the ranked mirrorlist"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
mv ranked_mirrorlist /etc/pacman.d/mirrorlist

echo "Install base packages"
pacstrap -i /mnt base base-devel

echo "Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Chroot to mnt"
arch-chroot /mnt

echo "Configurations"
passwd 
echo -n "Enter hostname > "
read hostname
echo $hostname >> /etc/hostname
echo "Set time zone"
ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime
echo "Set locale"
for locale_name in 'zh_TW.UTF-8 UTF-8' 'zh_TW BIG5' 'en_US.UTF-8 UTF-8' 'en_US ISO-8859-1'; do
    sed -i "s/^#$locale_name/$locale_name/" /etc/locale.gen
done
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
mkinitcpio -p linux
passwd

echo "GRUB"
pacman -S grub efibootmgr
grub-mkconfig -o /boot/grub/grub.cfg
grub-install {$device}

echo "Unmount and reboot"
exit
umount -R /mnt
reboot


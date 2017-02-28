echo -n "Enter the disk: "
read device

wipefs -a $device
parted $device mklabel gpt
parted $device mkpart ESP fat32 1M 513M
parted $device set 1 boot on
parted $device mkpart primary ext4 513M 100%
parted $device print

mkfs.fat ${device}1
mkfs.ext4 -O "^has_journal" ${device}2

mount ${device}2 /mnt
mkdir -p /mnt/boot/efi
mount ${device}1 /mnt/boot/efi

pacstrap -i /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

arch_chroot() {
    arch-chroot /mnt /bin/bash -c "${*}"
}

arch_chroot passwd
arch_chroot 'echo "arch-mac" > /etc/hostname'
arch_chroot mv /etc/localtime /etc/localtime.bak
arch_chroot ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime


for locale_name in 'zh_TW.UTF-8 UTF-8' 'zh_TW BIG5' 'en_US.UTF-8 UTF-8' 'en_US ISO-8859-1'; do
    arch_chroot "echo $locale_name >> /etc/locale.gen"
done

arch_chroot locale-gen
arch_chroot 'LANG=en_US.UTF-8 > /etc/locale.conf'
arch_chroot mkinitcpio -p linux

arch_chroot pacman -S iw wpa_supplicant dialog networkmanager --noconfirm
arch_chroot systemctl enable NetworkManager

arch_chroot useradd -m -g users -G wheel -s /bin/bash circle
arch_chroot passwd circle
arch_chroot visudo

arch_chroot pacman -S grub efibootmgr --noconfirm
arch_chroot grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
arch_chroot grub-mkconfig -o /boot/grub/grub.cfg

echo 
echo "Unmount and poweroff"
umount -R /mnt


grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
mv /boot/EFI/arch/System/ /boot/
rm -r /boot/EFI/
touch /boot/mach_kernel

/boot/System/Library/CoreServices/SystemVersion.plist
<?xml version="1.0" encoding="UTF-8"?>
 <plist version="1.0">
 <dict>
        <key>ProductBuildVersion</key>
        <string></string>
        <key>ProductName</key>
        <string>Linux</string>
        <key>ProductVersion</key>
        <string>Arch Linux</string>
 </dict>
 </plist>

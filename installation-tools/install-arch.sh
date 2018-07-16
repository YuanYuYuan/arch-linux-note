echo ">> Start installation ... "
echo ">> Set ntp"
timedatectl set-ntp true

device=/dev/sda
parted $device mklabel gpt
parted $device mkpart ESP fat32 1M 513M
parted $device set 1 boot on
parted $device mkpart primary ext4 513M 100%
parted $device print

echo 
echo ">> Format filesystem"
mkfs.fat ${device}1
mkfs.ext4 ${device}2

echo 
echo ">> Mount root and boot/efi"
mount ${device}2 /mnt
mkdir -p /mnt/boot/efi
mount ${device}1 /mnt/boot/efi

echo 
echo ">> Install base packages"
pacstrap /mnt base base-devel

echo 
echo ">> Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo 
echo "========== Configurations under chroot =========="
arch_chroot() {
    arch-chroot /mnt /bin/bash -c "${*}"
}

echo 
echo ">> Enter root password"
arch_chroot passwd 

arch_chroot mkinitcpio -p linux

echo 
echo ">> Basic paackges"
arch_chroot pacman -S dnsmq wget vim git iw wpa_supplicant dialog networkmanager --noconfirm
arch_chroot systemctl enable NetworkManager

echo ">> SSH"
arch_chroot pacman -S openssh --noconfirm
arch_chroot systemctl enable sshd

echo 
echo "Create a sudo user"
echo -n ">> Enter the username > "
read username
arch_chroot useradd -m -g users -G wheel -s /bin/bash $username
arch_chroot passwd $username

echo 
echo  ">> Add the wheel group to sudoers"
#arch_chroot 'sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers'
arch_chroot visudo

echo 
echo ">> GRUB"
arch_chroot pacman -S grub efibootmgr --noconfirm
arch_chroot grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
arch_chroot grub-mkconfig -o /boot/grub/grub.cfg
arch_chroot mkdir -p /boot/efi/EFI/BOOT
arch_chroot cp /boot/efi/EFI/grub/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI

echo 
echo "Unmount and poweroff"
umount -R /mnt
poweroff


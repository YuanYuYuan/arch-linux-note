echo ">> Start installation ... "
echo ">> Set ntp"
timedatectl set-ntp true

# echo
# echo -n ">> Enter the device (ex. /dev/sdx)to parted > "
# read device
device=/dev/sda
parted $device
# parted $device mklabel gpt
# parted $device mkpart ESP fat32 1M 513M
# parted $device set 1 boot on
# parted $device mkpart primary ext4 513M 100%
# parted $device print

echo ">> Format filesystem"
echo -n ">> Enter the part number to install Arch linux > "
read arch_part_number

arch_part=$device$arch_part_number
echo $arch_part
mkfs.ext4 $arch_part

echo ">> Mount root and boot/efi"
echo -n ">> Enter the part number to mount boot/efi > "
read boot_part_number

boot_part=$device$boot_part_number
mount $arch_part /mnt
mkdir -p /mnt/boot/efi
mount $boot_part /mnt/boot/efi




echo 
echo ">> Use the ranked mirrorlist"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
cp ranked_mirrorlist /etc/pacman.d/mirrorlist

echo 
echo ">> Install base packages"
# pacstrap /mnt base
pacstrap /mnt base base-devel

echo 
echo ">> Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab


arch_chroot() {
    arch-chroot /mnt /bin/bash -c "${*}"
}

echo 
echo ">> Configurations under chroot"
echo ">> Enter root password"
arch_chroot passwd 

echo 
echo ">> Enter hostname"
read hostname
# hostname=arch-vm
arch_chroot 'echo "$hostname" > /etc/hostname'

echo 
echo ">> Set time zone"
arch_chroot mv /etc/localtime /etc/localtime.bak
arch_chroot ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime
arch_chroot hwclock --systohc --utc

echo 
echo ">> Press enter to set locale"
arch_chroot vi /etc/locale.gen
# for locale_name in 'zh_TW.UTF-8 UTF-8' 'zh_TW BIG5' 'en_US.UTF-8 UTF-8' 'en_US ISO-8859-1'; do
#     arch_chroot 'sed -i "s/^#$locale_name/$locale_name/" /etc/locale.gen'
# done
arch_chroot locale-gen
arch_chroot 'echo "LANG=en_US.UTF-8" > /etc/locale.conf'
arch_chroot mkinitcpio -p linux

echo 
echo ">> Baisc network setting"
arch_chroot pacman -S iw wpa_supplicant dialog networkmanager --noconfirm
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
arch_chroot 'sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers'

echo 
echo ">> GRUB"
arch_chroot pacman -S grub efibootmgr os-prober --noconfirm
arch_chroot grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
arch_chroot grub-mkconfig -o /boot/grub/grub.cfg
arch_chroot mkdir -p /boot/efi/EFI/BOOT
arch_chroot cp /boot/efi/EFI/grub/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI

echo 
echo "Unmount and poweroff"
umount -R /mnt
poweroff




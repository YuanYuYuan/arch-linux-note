 #/dev/sda

#parted $device mkpart ESP fat32 1M 513M
#parted $device set 4 boot on
#parted $device mkpart primary linux-swap 513M 100%
#parted $device print

mkfs.fat /dev/sda4
mkswap /dev/sda5
swapon /dev/sda5
mkfs.ext4 /dev/sda6



mount /dev/sda6 /mnt
mkdir /mnt/boot
mount /dev/sda4 /mnt/boot

mv ranked_mirrolist /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

arch_chroot() {
    arch-chroot /mnt /bin/bash -c "${*}"
}

arch_chroot passwd
arch_chroot "echo arch-mac > /etc/hostname"
arch_chroot mv /etc/localtime /etc/localtime.bak
arch_chroot ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime


for locale_name in 'zh_TW.UTF-8 UTF-8' 'zh_TW BIG5' 'en_US.UTF-8 UTF-8' 'en_US ISO-8859-1'; do
    arch_chroot "echo $locale_name >> /etc/locale.gen"
done

arch_chroot locale-gen
arch_chroot "echo LANG=en_US.UTF-8 > /etc/locale.conf"
arch_chroot mkinitcpio -p linux

arch_chroot pacman -S iw wpa_supplicant dialog networkmanager --noconfirm
arch_chroot systemctl enable NetworkManager

arch_chroot useradd -m -g users -G wheel -s /bin/bash circle
arch_chroot passwd circle
arch_chroot visudo

arch_chroot bootctl --path=/boot install

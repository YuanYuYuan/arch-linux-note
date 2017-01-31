# wifi settings

```sh
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/broadcom-wl.tar.gz
tar -zxvf broadcom-wl.tar.gz
cd broadcom-wl
makepkg -s
pacman -U broadcom-wl-*.pkg.tar.xz
rmmod b43
rmmod ssb
modprobe wl
```

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1318218

# fan, temperature sensor

```sh
sudo pacman -S lm_sensors
sudo sensors-detect
sensors

yaourt -S mbpfan-git
vim /etc/mpbfan.conf
sudo systemctl enable mbpfan
sudo systemctl start mbpfan
```


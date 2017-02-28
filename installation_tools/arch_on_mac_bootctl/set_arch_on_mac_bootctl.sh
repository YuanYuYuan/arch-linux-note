#!/bin/bash

root_UUID=$(blkid -s PARTUUID -o value /dev/sd6)
echo "options root=PARTUUID=$root_UUID rw" >> arch.conf
cp ./loader.conf /boot/loader/loader.conf
cp ./arch.conf /boot/loader/entries/loader.conf

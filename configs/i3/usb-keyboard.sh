#!/bin/bash
xmodmap ~/.Xmodmap
touch /home/circle/.config/i3/test
notify-send "udev" "USB keyboard"

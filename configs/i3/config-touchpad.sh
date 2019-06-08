#!/bin/bash

device=$(xinput --list | grep -i 'touchpad' | cut -d '=' -f 2 | cut -d '[' -f 1)
xinput --set-prop $device "libinput Accel Speed" 0.5
xinput --set-prop $device "libinput Tapping Enabled" 1
xinput --set-prop $device "libinput Natural Scrolling Enabled" 1

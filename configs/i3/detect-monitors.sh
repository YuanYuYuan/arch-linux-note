#!/bin/bash

i3folder=$HOME/.config/i3
normal_mode=0
while true; do
    if [ -z "$(xrandr --query | grep '\bconnected\b' | grep -v 'eDP-1')" ]; then
        if [ $normal_mode -ne 1 ]; then
            $i3folder/switch-monitors.sh normal
            normal_mode=1
        fi
    else
        normal_mode=0
    fi
    sleep 1s
done

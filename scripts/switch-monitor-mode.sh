#!/bin/bash

file=/tmp/monitor_mode

case $(cat $file 2> /dev/null) in 
    1)
        echo 2 > $file
        # switch to mode: single HDMI
        xrandr --output VGA-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --off
        ;;
    2)
        echo 3 > $file
        # switch to mode: dual display
        xrandr --output VGA-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal
        ;;
    3)
        echo 4 > $file
        # switch to mode: mirror 
        xrandr --output VGA-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
    *)
        echo 1 > $file
        # switch to mode: default, single eDP
        xrandr --output VGA-1 --off --output HDMI-1 --off --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
esac


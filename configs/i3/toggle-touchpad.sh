#!/bin/bash

device=$(xinput --list | grep -i 'touchpad' | cut -d '=' -f 2 | cut -d '[' -f 1)
state=`xinput list-props $device | grep "Device Enabled" | grep -o "[01]$"`

if [ $state == '1' ];then
  xinput --disable $device
else
  xinput --enable $device
fi

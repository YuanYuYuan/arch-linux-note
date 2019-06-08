#!/bin/bash

img=/tmp/snapshot.png
if [ "$1" == "" ]; then
    seconds=10
else
    seconds=$1
fi

termdown $1 && import -window $(xdotool getwindowfocus) $img && feh $img

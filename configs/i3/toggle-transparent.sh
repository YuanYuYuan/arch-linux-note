#! /bin/sh


if [ "$(pgrep compton)" == "" ]; then
    compton -b --config=$HOME/.config/compton/compton.conf
else
    pkill compton
fi

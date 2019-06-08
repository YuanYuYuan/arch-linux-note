#!/usr/bin/env bash

mixer='termite -e ncpamixer' 

case $BLOCK_BUTTON in
	1) pamixer -t ;;
    3) i3-msg exec "$mixer" > /dev/null ;;
	4) pamixer -i 5 ;;
	5) pamixer -d 5 ;;
esac


printpastatus() { 
    [[ $(pamixer --get-mute) = "true" ]] && echo " mute" && exit
    echo  "<span color='#C0C0C0'> $(pamixer --get-volume)%</span>"
}
printpastatus

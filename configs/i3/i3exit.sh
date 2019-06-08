#!/bin/sh

lock() {
    xset dpms force off
    xset dpms 10
    i3lock -e -n -i ~/Pictures/dark-arch-2.png
    xset dpms 120
}

output_sink="$(pactl list short sinks | grep output | head -n1 | cut -f2)"

case "$1" in
    lock)
        lock
        ;;
    logout )
        i3-msg exit
        ;;
    suspend)
        pactl set-sink-mute $output_sink 1
        systemctl suspend&
        lock
        pactl set-sink-mute $output_sink 0
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
esac
exit 0

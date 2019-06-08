#!/usr/bin/env bash

filter() {
    tr '\n' ' ' | grep -Po '.*(?= \[playing\])|paused' |\
        tr -d '\n' | cut -c -40 | iconv -c
}

player='termite -e ncmpcpp'

case $BLOCK_BUTTON in
    1) mpc toggle | filter ;;                                   # right click, pause/unpause
    3) mpc status | filter && i3-msg exec "$player" > /dev/null;; # left click, launch ncmpcpp
    4) mpc prev   | filter ;;                                   # scroll up, previous
    5) mpc next   | filter ;;                                   # scroll down, next
    *) mpc status | filter ;;                                   # show mpd status
esac

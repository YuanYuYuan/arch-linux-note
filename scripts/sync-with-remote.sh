#!/usr/bin/env bash

remote="z-gotham:~/cyberknife/tasks/training"

while true; do 
    file=$(inotifywait -q --fromfile list --format %w --event move_self) 
    info="transfer $file to $remote"
    echo "$info"
    scp $file $remote
    # notify-send "$info ... done!"
done

#!/bin/bash

if [ "$1" == "" ]; then
    echo "Please specify file name!"
    exit
fi

# compile=asciidoctor
compile="asciidoctor-latex -b html"
browser="firefox"
adoc_file=${1%.*}.adoc
html_file=${1%.*}.html
$compile $adoc_file
$browser $html_file 2> /dev/null&


# guard reload
guard_reload_file="$HOME/Workings/scripts/guard-reload.rb"
guard -i -G $guard_reload_file&

while true; do
    inotifywait $adoc_file && $compile $adoc_file
done

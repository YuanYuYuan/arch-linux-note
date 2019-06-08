#!/bin/bash

if [ "$1" == "" ]; then
    echo "Please specify file name!"
    exit
fi

compile="texfot pdflatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape"
browser=zathura
# browser='zathura -s -x "gvim --servername $1 -c \"let g:syncpdf='$1'\" --remote +%{line} %{input}" $*'
tex_file=${1%.*}.tex
pdf_file=${1%.*}.pdf

$compile $tex_file
$browser $pdf_file 2> /dev/null&

while true; do
    inotifywait $tex_file && $compile $tex_file
done

#!/bin/sh
wget \
    --recursive \
    --no-clobber \
    --page-requisites \
    --html-extension \
    --convert-links \
    --domains $1 \
    --no-parent $2

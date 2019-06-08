#!/usr/bin/env bash

case $BLOCK_BUTTON in
	4) light -A 5;;
	5) light -U 5;;
esac
echo  "<span color='#C0C0C0'> $(printf "%d" $(light))%</span>"

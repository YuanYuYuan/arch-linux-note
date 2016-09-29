#!/bin/sh

pdf="$1"
shift
passthrou="$@"

if [ ! -e $pdf ]; then
	echo "$pdf: No such file or directory"
	exit 1
fi

llpp $pdf $passthrou &
pid_llpp=$!

# kill the llpp instance if the shell script terminates
trap "kill ${pid_llpp}" SIGINT SIGTERM SIGQUIT SIGKILL

# watch for changes in the directory of the given file
inotifywait -m -e close_write "$PWD" | while read dir ev file; do
	if [ "$file" = "$pdf" ] && [ -e "$pdf" ]; then
		kill -HUP $pid_llpp
	fi
done &

# kill inotify if llpp terminates
pid_inotify=$(jobs -p | grep -v $pid_llpp)
wait $pid_llpp
kill $pid_inotify

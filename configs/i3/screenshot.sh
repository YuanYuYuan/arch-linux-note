#! /bin/bash

case $1 in
    "")
        # scrot -s -e 'xclip -se c -i -t image/png < $f && mv $f /tmp'
        import -trim /tmp/screenshot.png
        xclip -selection clipboard -target image/png -in < /tmp/screenshot.png
        ;;
    *)
        # scrot -s ${1}.png
        import -trim ${1}.png
        ;;
esac



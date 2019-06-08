#!/usr/bin/env bash

mem=$(free -m | awk 'NR==2{printf "%.2f", $3/1024 }')
echo "<span color='#FF4500'>$mem G</span>"
#!/usr/bin/env bash

htop='termite -e htop' 

case $BLOCK_BUTTON in
    3) i3-msg exec "$htop" > /dev/null ;;
esac

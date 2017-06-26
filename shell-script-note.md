# Shell Script Note

This a note for shell script

-------------------------------

## Change the file extension from .a.b to .b

```sh
for file in *.b; do   
echo  ${file%.a.b}.b    
done
```
## Convert png to jpg

```sh
for file in *.png; do 
convert $file ${file%.*}.jpg
done
```


## Use ls + grep + xargs + COMMAND to edit file.

```sh
ls | grep 'PATTERN' | xargs -d '\n' -I {} COMMAND {}
```

## wget files in list

```sh
xargs -n 1 wget < filei-urls
```

## Use python to decode/encode url

/usr/local/bin/urlencode

```python
#!/usr/bin/env python
import sys, urllib.parse as up 
print(up.quote_plus(sys.argv[1]))
```

/usr/local/bin/urldecode

```python
#!/usr/bin/env python
import sys, urllib.parse as up 
print(up.unquote_plus(sys.argv[1]))
```

## use rsync to copy 

```sh
rsync -ahP SOURCE DESTINATION
```

## cp with pv to monitor progress

```sh
pv FILE > DESTINATION
```

## switch caps key and left ctrl

~/.Xmodmap

```sh
!
! Swap Caps_Lock and Control_L
!
remove Lock = Caps_Lock
remove Control = Control_L
keysym Control_L = Caps_Lock
keysym Caps_Lock = Control_L
add Lock = Caps_Lock
add Control = Control_L
```

```sh
xmodmap ~/.Xmodmap
```

## Network Manager CLI

```sh
nmcli radio wifi on
nmcli radio wifi off
nmcli dev wifi
nmcli con up id ID
nmcli con down id ID
```


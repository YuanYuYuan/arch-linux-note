#!/usr/bin/env bash

maildir="$HOME/Mails/*/*/new/"

old=0
mail_list=$(ls $HOME/Mails)

declare -A old=()
for mailbox in $mail_list; do 
    old+=([$mailbox]=0)
    echo $mailbox
done

echo
for mailbox in $mail_list; do 
    echo ${old[$mailbox]}
done

while true; do
    for mailbox in $mail_list; do 
        new=$(ls $HOME/Mails/$mailbox/INBOX/new | wc -l)
        # echo $mailbox: $new
        if [ "$new" -gt "${old[$mailbox]}" ]; then
            notify-send "$mailbox" "new mail: $new"
        fi
        sleep 1
        old[$mailbox]=$new
    done
done

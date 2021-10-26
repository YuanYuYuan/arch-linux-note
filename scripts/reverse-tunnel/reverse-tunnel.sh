#!/usr/bin/env bash

autossh \
    -M 0 \
    -o "ServerAliveInterval 30" \
    -o "ServerAliveCountMax 3" \
    -N \
    -R PORT:localhost:22 \
    -i SSH_PRIVATE_KEY \
    USERHOST

#!/usr/bin/env python
import os

exclude_files = [line.strip() for line in open('./exclude-list.txt', 'r')]
exclude = "{"
for i, e in enumerate(exclude_files):
    if i > 0:
        exclude += ","
    exclude += "\"" + e + "\""
exclude += "}"

backup_command = "rsync -aAXv --exclude="
backup_start = "/"
backup_end = "/run/media/circle/toshiba-linux/backup/arch-linux-backup"

print(backup_command + exclude + " " + backup_start + " " + backup_end)
os.system("sudo " + backup_command + exclude + " " +
          backup_start + " " + backup_end)

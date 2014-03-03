#!/bin/bash

set -e

source /etc/profile.d/swift-dreamobjects.sh
cd /mnt/backup/

FOUND=`find . -type f -mtime -1 | wc -l`

if [ $FOUND -eq 0 ]; then
    echo 'No backup files to upload?'
    exit 1
fi

find . -type f -mtime -1 -exec swift upload wpd-backups {} \;


exit 0

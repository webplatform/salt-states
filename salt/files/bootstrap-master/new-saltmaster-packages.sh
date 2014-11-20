#!/bin/bash

if [ ! -f "/srv/ci-dreamobjects.sh" ]; then
    echo "Cannot find ci-dreamobjects, did you run state.highstate yet?"
    exit 1
fi

cd /srv
. ci-dreamobjects.sh
mkdir -p code/packages
cd code/packages
swift list wpd-packages > filesList
while read FILE; do swift download wpd-packages $FILE ; done < filesList
rm filesList
chown -R nobody:deployment /srv/code/packages

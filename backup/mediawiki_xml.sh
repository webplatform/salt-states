#!/bin/bash

cd /srv/salt/code/docs/current
php maintenance/dumpBackup.php --full --uploads | nice -n 19 gzip -9 > /mnt/backup/wiki-wpwiki-$(date '+%Y%m%d').xml.gz
cd -

#!/bin/bash

nice -n 19 mysqldump -u root wpwiki -c | nice -n 19 gzip -9 > /mnt/backup/wiki-wpwiki-$(date '+%Y%m%d').sql.gz

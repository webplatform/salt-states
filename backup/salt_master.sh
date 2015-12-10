#!/bin/bash

tar -czvf /mnt/backup/salt-master-$(date '+%Y%m%d').tar.gz /srv/pillar /srv/salt /srv/private

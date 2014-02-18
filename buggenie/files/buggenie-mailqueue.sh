#!/bin/bash -l
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` ran TheBugGenie recurring mail queue process"
cd /srv/webplatform/buggenie
/usr/bin/php ./tbg_cli mailing:process_mail_queue --limit=20

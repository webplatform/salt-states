#!/bin/bash -l
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` ran TheBugGenie recurring mail queue process"
#cd /srv/webplatform/buggenie
#/usr/bin/php ./tbg_cli mailing:process_mail_queue --limit=20

output=$(mktemp)
cd /srv/webplatform/buggenie
/usr/bin/php ./tbg_cli mailing:process_mail_queue --limit=20 > $output 2>&1
code=$?

if [ "$code" -ne 0 ] ; then
  /usr/bin/logger -i -p local1.error -t cron "[error] Host `hostname` ran TheBugGenie and exited with nonzero status: $code"
  cat $output
  exit $code
fi
rm $output

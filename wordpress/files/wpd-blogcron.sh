#!/bin/bash

#
# Running Cron jobs without relying on visitors to do so
#
# https://rtcamp.com/tutorials/wordpress/wp-cron-crontab/

set -e

if [ -z "$JOBNAME" ] ; then
  echo "No jobname given. Please set JOBNAME in environment."
  exit 1
fi

logger -i -p local1.notice -t cron "[notice] Host `hostname` ran $JOBNAME"

output=$(mktemp)

cd /srv/webplatform/blog/wordpress

/usr/bin/php wp-cron.php > $output 2>&1

code=$?

if [ "$code" -ne 0 ] ; then
  logger -i -p local1.error -t cron "[error] Host `hostname` ran $JOBNAME and exited with nonzero status: $code"
  cat $output
  exit $code
fi
cat $output
rm $output

exit 0

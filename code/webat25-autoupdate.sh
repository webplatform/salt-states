#!/bin/bash

# https://github.com/saltstack/salt/issues/4176

set -e

logger -i -p local1.notice -t cron "[notice] Host `hostname` ran WebAt25 auto-updater"

output=$(mktemp)

cd /srv/code/web25ee/docroot
su -c 'git pull' renoirb > $output 2>&1
salt blog0 state.sls code.webat25 >> $output 2>&1
#salt blog0 state.sls apache.webat25
#salt 'memcache*' cmd.run 'echo "flush_all" | nc localhost 11211'

code=$?

if [ "$code" -ne 0 ] ; then
  logger -i -p local1.error -t cron "[error] Host `hostname` ran WebAt25 auto-updater and exited with nonzero status: $code"
  cat $output
  exit $code
fi
cat $output
#rm $output

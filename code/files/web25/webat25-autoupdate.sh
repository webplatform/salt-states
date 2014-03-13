#!/bin/bash

#
# Updating and refreshing code for WebAt25.org
#
# https://github.com/saltstack/salt/issues/4176

set -e

logger -i -p local1.notice -t cron "[notice] Host `hostname` ran WebAt25 auto-updater"

output=$(mktemp)

cd /srv/code/web25ee/docroot
su -c 'git pull' renoirb > $output 2>&1

salt 'webat25*' state.sls code.webat25 >> $output 2>&1

#salt blog0 state.sls code.webat25 >> $output 2>&1
#salt 'memcache*' cmd.run 'echo "flush_all" | nc localhost 11211'

#curl -H 'Fastly-Key: 09e13e3e21e03ffb21936728f37e0035' -H 'Content-Accept: application/json' -XPOST https://api.fastly.com/service/2pDmWpxcDqmxmalvAcgtYH/purge_all

code=$?

if [ "$code" -ne 0 ] ; then
  logger -i -p local1.error -t cron "[error] Host `hostname` ran WebAt25 auto-updater and exited with nonzero status: $code"
  cat $output
  exit $code
fi
cat $output
rm $output

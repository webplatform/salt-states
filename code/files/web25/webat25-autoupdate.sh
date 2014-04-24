#!/bin/bash

#
# Updating and refreshing code for WebAt25.org
#
# https://github.com/saltstack/salt/issues/4176

set -e

logger -i -p local1.notice -t cron "[notice] Host `hostname` ran WebAt25 auto-updater"

output=$(mktemp)

cd /srv/code/web25ee/docroot

su -c 'git remote update' renoirb > $output 2>&1

#
# Source: http://stackoverflow.com/questions/3258243/git-check-if-pull-needed
#
COUNT=$(git rev-list HEAD...origin/master --count)

if [ "$COUNT" -ge  "1" ]; then
    su -c 'git pull' renoirb > $output 2>&1

    salt 'webat25*' state.sls code.webat25 >> $output 2>&1

    #salt 'memcache*' cmd.run 'echo "flush_all" | nc localhost 11211'
    #curl -H 'Fastly-Key: FASTLY_KEY' -H 'Content-Accept: application/json' -XPOST https://api.fastly.com/service/SERVICE_ID/purge_all
    logger -i -p local1.notice -t cron "[notice] Host `hostname` WebAt25 auto-update -- updated"
else
    logger -i -p local1.notice -t cron "[notice] Host `hostname` WebAt25 auto-updater -- nothing to do"
    exit 0
fi

# Not sure of the validity of this
code=$?

if [ "$code" -ne 0 ] ; then
  logger -i -p local1.error -t cron "[error] Host `hostname` ran WebAt25 auto-updater and exited with nonzero status: $code"
  cat $output
  exit $code
fi
cat $output
rm $output

exit 0

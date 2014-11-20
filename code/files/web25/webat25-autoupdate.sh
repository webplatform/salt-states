#!/bin/bash

#
#

if [ "$CODE_PATH" == "" ]; then
    echo "Please provide the CODE_PATH env variable"
    exit 1
fi

logger -i -p local1.notice -t cron "[notice] Host `hostname` ran code auto-updater"

if [ ! -d "$CODE_PATH" ]; then
    MSG="[notice] Host `hostname` auto-updater -- no code directory found"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG
    exit 2
fi

# @todo: generic username
USER=$(whoami)
output=$(mktemp)

cd $CODE_PATH

# Check if $CODE_PATH is a git repository
if [ ! -d "$CODE_PATH/.git" ]; then
    MSG="[notice] Host `hostname` auto-updater -- no git repository found in $CODE_PATH"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG
    exit 3
fi

# @todo: what this done
su -c 'git remote update' $USER > $output 2>&1

GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

#
# Source: http://stackoverflow.com/questions/3258243/git-check-if-pull-needed
#
COUNT=$(git rev-list HEAD...origin/$GIT_BRANCH --count)

if [ "$COUNT" -ge  "1" ]; then
    # @todo: or reset head ?
    su -c 'git pull' $USER > $output 2>&1

    # @todo: execute other commands.

    #salt 'webat25*' state.sls code.webat25 >> $output 2>&1
    #salt 'memcache*' cmd.run 'echo "flush_all" | nc localhost 11211'
    #curl -H 'Fastly-Key: FASTLY_KEY' -H 'Content-Accept: application/json' -XPOST https://api.fastly.com/service/SERVICE_ID/purge_all

    MSG="[notice] Host `hostname` auto-update -- updated"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG
else
    MSG="[notice] Host `hostname` auto-updater -- no new commit, nothing to do"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG
    exit 0
fi

cat $output
rm $output

exit 0

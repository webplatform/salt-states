#!/bin/bash

# @author Etienne Lachance <el@elcweb.ca>
#
DEFAULT_MSG="[notice] Host `hostname`"

logger -i -p local1.notice -t cron "$DEFAULT_MSG ran code vendors installer"

if [ "$CODE_PATH" == "" ]; then
    echo "Please provide the CODE_PATH env variable"
    exit 1
fi

if [ ! -d "$CODE_PATH" ]; then
    MSG="[notice] Host `hostname` auto-updater -- no code directory found"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG
    exit 2
fi

output=$(mktemp)

cd $CODE_PATH

# Check if $CODE_PATH as composer.json
if [ -a "composer.json" ]; then
    MSG="$DEFAULT_MSG run composer install"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG

    php composer.phar install > $output 2>&1
fi


# Check if $CODE_PATH as package.json
if [ -a "package.json" ]; then
    MSG="$DEFAULT_MSG run npm install"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG

    npm install > $output 2>&1
fi

# Check if $CODE_PATH as bower.json
if [ -a "bower.json" ]; then
    MSG="$DEFAULT_MSG run composer install"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG

    bower install > $output 2>&1
fi


cat $output
rm $output

exit 0


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

echo -ne "Moved into code repository: $(pwd)\n"

# Check if $CODE_PATH as composer.json
if [ -f "${CODE_PATH}/composer.json" ]; then
    if [ ! -a "composer.phar" ]; then
        MSG="$DEFAULT_MSG composer.phar is missing, downloaded locally"
        logger -i -p local1.notice -t cron $MSG
        echo $MSG

        curl -sS https://getcomposer.org/installer | php
    fi
    MSG="$DEFAULT_MSG run composer install"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG

    php composer.phar install > $output 2>&1
fi


# Check if $CODE_PATH as package.json
if [ -f "${CODE_PATH}/package.json" ]; then
    MSG="$DEFAULT_MSG run npm install"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG

    npm install > $output 2>&1
fi

# Check if $CODE_PATH as bower.json
if [ -f "${CODE_PATH}/bower.json" ]; then
    if [ ! -f "${CODE_PATH}/node_modules/bower/bin/bower" ]; then
        MSG="$DEFAULT_MSG did not find bower, installing locally"
        logger -i -p local1.notice -t cron $MSG
        echo $MSG

        npm install bower
    fi
    MSG="$DEFAULT_MSG run bower install"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG

    node_modules/bower/bin/bower install > $output 2>&1
fi


cat $output
rm $output

exit 0


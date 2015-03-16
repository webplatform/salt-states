#!/bin/bash

output=$(mktemp)
code=0

if [ -f /var/lib/lurker/db ] ; then
	/usr/bin/lurker-prune > $output 2>&1
	code=$?
fi

if [ "$code" -ne 0 ] ; then
	/usr/bin/logger -i -p local1.error -t cron "[error] Host `hostname` ran lurker updater, exited with error: $code"
	cat $output
	exit $code
fi

rm $output

exit $code


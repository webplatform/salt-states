#!/bin/bash

#
# Annotator Upstart script (runner)
# 
# file: /srv/webplatform/h/service.sh
# Gist: https://gist.github.com/WebPlatformDocs/1ba5b980b52303b62acf/edit
#
set -e
LOGFILE=/var/log/webplatform/hypothesis.log
LOGDIR=$(dirname $LOGFILE)
cd /srv/webplatform/h
. bin/activate
test -d $LOGDIR || mkdir -p $LOGDIR
exec bin/gunicorn --paster h.ini --log-config h.ini

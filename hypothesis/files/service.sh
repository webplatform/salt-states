#!/bin/bash

#
# Annotator Upstart script (runner)
# 
# file: /srv/webplatform/notes-server/service.sh
# Gist: https://gist.github.com/WebPlatformDocs/1ba5b980b52303b62acf/edit
# source bin/activate ; bin/python bin/gunicorn --reload --paste h.ini --log-config h.ini
#
set -e
LOGDIR=$(dirname $LOGFILE)
source bin/activate
test -d $LOGDIR || mkdir -p $LOGDIR
exec bin/gunicorn --reload --paste h.ini --log-config h.ini

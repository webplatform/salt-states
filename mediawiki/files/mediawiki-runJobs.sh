#!/bin/bash -l
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` started MediaWiki Job Runner"
/usr/bin/php /srv/webplatform/wiki/current/maintenance/runJobs.php

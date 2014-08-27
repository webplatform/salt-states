#!/bin/bash -l
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` started MediaWiki Job Runner (live wiki)"
/usr/bin/timeout 3100 /usr/bin/php /srv/webplatform/wiki/wpwiki/mediawiki/maintenance/runJobs.php
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` started MediaWiki Job Runner (test wiki)"
/usr/bin/timeout 3100 /usr/bin/php /srv/webplatform/wiki/wptestwiki/mediawiki/maintenance/runJobs.php
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` stopped MediaWiki JobRunner"

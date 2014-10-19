coreutils:
  pkg.installed

## In order to have the ability to run sitemap.xml automatically
##
## script:
##
##     php maintenance/generateSitemap.php --fspath ~/sitemaps --server http://docs.webplatformstaging.org/wiki/ --urlpath http://www.webplatformstaging.org/sitemaps
##
## Plus minimal LocalSettings.php
##
mediawiki-runner-deps:
  pkg.installed:
    - names:
      - php5-memcached
      - php5-mysqlnd

/srv/webplatform/wiki/mediawiki-runJobs.sh:
  file.managed:
    - mode: 755 
    - user: dhc-user
    - group: dhc-user
    - source: salt://mediawiki/files/mediawiki-runJobs.sh

mediawiki_cron_1:
  cron.present:
    - identifier: mediawiki-runjobs-1
    - user: dhc-user
    - minute: random
    - name: "/srv/webplatform/wiki/mediawiki-runJobs.sh #1st run"
    - require:
      - file: /srv/webplatform/wiki/mediawiki-runJobs.sh

mediawiki_cron_2:
  cron.present:
    - identifier: mediawiki-runjobs-2
    - minute: random
    - user: dhc-user
    - name: "/srv/webplatform/wiki/mediawiki-runJobs.sh #2nd run"
    - require:
      - file: /srv/webplatform/wiki/mediawiki-runJobs.sh

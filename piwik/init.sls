include:
  - php.apache
  - php

php-piwik:
  pkg:
    - latest
    - names:
      - php5-mysql

/srv/webplatform/piwik/tmp:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

/srv/webplatform/piwik/config:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

piwik_archive_cron:
  cron.present:
    - minute: 5
    - user: www-data
    - name: '/usr/bin/php /srv/webplatform/piwik/misc/cron/archive.php -- url=http://tracking.webplatform.org/piwik/ > /var/log/piwik-archive.log'

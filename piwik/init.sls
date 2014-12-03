include:
  - cron
  - php
  - mysql
  - piwik.php-fpm

php-piwik:
  pkg.installed:
    - pkgs:
      - php5-gd
      - php-image-text
      - php5-curl
      - php5-mysqlnd
      - php-db

piwik-archive-requirements:
  pkg.installed:
    - pkgs:
      - php5-dev
      - build-essential

piwik-geoip:
  pkg.installed:
    - pkgs:
      - php5-geoip
      - libgeoip-dev

/etc/php5/mods-available/geoip.ini:
  file.managed:
    - source: salt://piwik/files/php.geoip.ini
    - require:
      - pkg: piwik-geoip

# mailto.sh is part of cron/init.sls
/usr/bin/piwik-archive.sh:
  file.managed:
    - mode: 755 
    - user: www-data
    - group: www-data
    - source: salt://piwik/files/piwik-archive.sh
    - require:
      - pkg: php-basic-deps
  cron.present:
    - identifier: piwik-archive
    - user: www-data
    - minute: 5
    - require:
      - file: /usr/bin/piwik-archive.sh
      - file: /etc/profile.d/mailto.sh


include:
  - cron
  - php
  - mysql
  - piwik.php-fpm
  - nodejs
  - users.app-user


exclude:
  - file: /etc/php5/mods-available/memcached.ini


piwik-bower:
  pkg.installed:
    - name: npm
    - require:
      - pkg: nodejs
  npm.installed:
    - name: bower
    - require:
      - pkg: npm


php-piwik:
  pkg.installed:
    - pkgs:
      - php5-gd
      - php-image-text
      - php5-curl
      - php5-mysqlnd
      - php-db
      - php5-dev
      - php5-geoip
      - libgeoip-dev


piwik-archive-requirements:
  pkg.installed:
    - pkgs:
      - php5-dev
      - build-essential


# mailto.sh is part of cron/init.sls
/usr/bin/piwik-archive.sh:
  file.managed:
    - mode: 755
    - user: app-user
    - group: www-data
    - source: salt://piwik/files/piwik-archive.sh.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
    - require:
      - pkg: php-basic-deps
  cron.present:
    - identifier: piwik-archive
    - user: app-user
    - minute: 5
    - require:
      - file: /usr/bin/piwik-archive.sh
      - file: /etc/profile.d/mailto.sh


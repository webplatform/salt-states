include:
  - cron
  - php
  - mysql
  - piwik.php-fpm
  - nodejs


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
      - unzip


piwik-archive-requirements:
  pkg.installed:
    - pkgs:
      - php5-dev
      - build-essential


# mailto.sh is part of cron/init.sls
/usr/bin/piwik-archive.sh:
  file.managed:
    - mode: 755
    - user: webapps
    - group: www-data
    - source: salt://piwik/files/piwik-archive.sh.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
    - require:
      - pkg: php-basic-deps
  cron.present:
    - identifier: piwik-archive
    - user: webapps
    - minute: 5
    - require:
      - file: /usr/bin/piwik-archive.sh
      - file: /etc/profile.d/mailto.sh

/srv/webplatform/stats-server/tmp:
  file.directory:
    - user: webapps
    - group: www-data
    - mode: 775
    - makedirs: True
    - recurse:
      - user
      - group
      - mode


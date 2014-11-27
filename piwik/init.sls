{#
 # Piwik Salt stack config
 #
 # See also:
 #   - https://github.com/perusio/piwik-nginx.git
 #}
include:
  - cron
  - php
  - mysql

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

/etc/nginx/conf.d/geoip.conf:
  file.managed:
    - source: salt://piwik/files/nginx.geoip.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
      - pkg: piwik-geoip

/usr/bin/piwik-archive.sh:
  file.managed:
    - mode: 755 
    - user: www-data
    - group: www-data
    - source: salt://piwik/files/piwik-archive.sh
  cron.present:
    - identifier: piwik-archive
    - user: www-data
    - minute: 5
    - require:
      - file: /usr/bin/piwik-archive.sh
      - file: /etc/profile.d/mailto.sh
      - file: /etc/nginx/conf.d/geoip.conf


/etc/nginx/sites-available/piwik:
  file.managed:
    - source: salt://piwik/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        site: piwik
    - watch_in:
      - service: nginx
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/piwik:
  file.symlink:
    - target: /etc/nginx/sites-available/piwik
    - require:
      - pkg: nginx
      - file: /etc/nginx/sites-available/piwik


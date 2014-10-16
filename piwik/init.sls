include:
  - cron
  - php
  - mysql
  - nginx
  - php.fpm
  - piwik.config

php-piwik:
  pkg:
    - installed
    - names:
      - php5-gd
      - php-image-text
      - php5-curl
      - php5-mysqlnd
      - php-db

/etc/nginx/sites-enabled/default:
  file.absent

/srv/webplatform/piwik/tmp:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

/etc/php5/fpm/pool.d/www.conf:
  file.append:
    - text: |
        ; Managed by Salt Stack from state piwik/init.sls
        pm.max_children = 30
        pm.start_servers = 10
        pm.min_spare_servers = 5
        pm.max_spare_servers = 20
        pm.max_requests = 500
        env[HOSTNAME] = $HOSTNAME
        env[PATH] = /usr/local/bin:/usr/bin:/bin
        env[TMP] = /tmp
        env[TMPDIR] = /tmp
        env[TEMP] = /tmp


piwik-archive-requirements:
  pkg:
    - installed
    - names:
      - php5-geoip
      - php5-dev
      - libgeoip-dev
      - build-essential
  pecl.installed:
    - name: geoip

/etc/php5/mods-available/geoip.ini:
  file.managed:
    - source: salt://piwik/files/geoip.ini
    - require:
      - pkg: php5-geoip

/etc/nginx/conf.d/geoip.conf:
  file.managed:
    - source: salt://piwik/nginx-geoip.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
      - pkg: php5-geoip

append-fastcgi:
  file.append:
    - name: /etc/nginx/fastcgi_params
    - text:
      - '# Added by salt stack on manifest piwik.archive'
      - fastcgi_param   GEOIP_ADDR              $remote_addr;
      - fastcgi_param   GEOIP_COUNTRY_CODE      $geoip_country_code;
      - fastcgi_param   GEOIP_COUNTRY_NAME      $geoip_country_name;
      - fastcgi_param   GEOIP_REGION            $geoip_region;
      - fastcgi_param   GEOIP_REGION_NAME       $geoip_region_name;
      - fastcgi_param   GEOIP_CITY              $geoip_city;
      - fastcgi_param   GEOIP_AREA_CODE         $geoip_area_code;
      - fastcgi_param   GEOIP_LATITUDE          $geoip_latitude;
      - fastcgi_param   GEOIP_LONGITUDE         $geoip_longitude;
      - fastcgi_param   GEOIP_POSTAL_CODE       $geoip_postal_code;
    - require:
      - file: fastcgi-orig
      - pkg: php5-geoip

/usr/bin/piwik-archive.sh:
  file.managed:
    - mode: 755 
    - user: www-data
    - group: www-data
    - source: salt://piwik/piwik-archive.sh
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
    - source: salt://piwik/files/vhost.conf.jinja
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


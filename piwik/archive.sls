include:
  - cron

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

/etc/php5/conf.d/geoip.ini:
  file.append:
    - text:
      - '; Added for PECL php extension via Salt stack piwik.archive state'
      - geoip.custom_directory=/srv/webplatform/piwik/misc

/etc/nginx/conf.d/geoip.conf:
  file.managed:
    - source: salt://piwik/nginx-geoip.conf
    - user: root
    - group: root
    - mode: 644

update-fastcgi-params:
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
      - file: /etc/nginx/fastcgi_params

/usr/bin/piwik-archive.sh:
  file.managed:
    - mode: 755 
    - user: www-data
    - group: www-data
    - source: salt://piwik/piwik-archive.sh
  cron.present:
    - user: www-data
    - minute: 5
    - require:
      - file: /usr/bin/piwik-archive.sh
      - file: /etc/profile.d/mailto.sh
      - file: /etc/nginx/conf.d/geoip.conf

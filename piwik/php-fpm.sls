include:
  - piwik
  - php-fpm

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

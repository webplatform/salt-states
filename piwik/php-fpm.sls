include:
  - piwik
  - nginx
  - php-fpm

append-nginx-fpm-geoip:
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
      - pkg: piwik-geoip
      - pkg: nginx


include:
  - piwik
  - nginx
  - php-fpm


append-nginx-fpm-geoip:
  file.append:
    - name: /etc/nginx/fastcgi_params
    - text:
      - '# Added by Salt Stack at piwik/php-fpm.sls. It will use Fastly GeoIP data'
      - fastcgi_param GEOIP_AREA_CODE           $HTTP_X_GEO_AREA_CODE;
      - fastcgi_param GEOIP_REGION              $HTTP_X_GEO_REGION;
      - fastcgi_param GEOIP_CITY                $HTTP_X_GEO_CITY;
      - fastcgi_param GEOIP_LATITUDE            $HTTP_X_GEO_LATITUDE;
      - fastcgi_param GEOIP_LONGITUDE           $HTTP_X_GEO_LONGITUDE;
      - fastcgi_param GEOIP_POSTAL_CODE         $HTTP_X_GEO_POSTAL_CODE;
      - fastcgi_param GEOIP_COUNTRY_CODE        $HTTP_X_GEO_COUNTRY_CODE;
      - fastcgi_param GEOIP_COUNTRY_NAME        $HTTP_X_GEO_COUNTRY_NAME;
      - fastcgi_param GEOIP_ADDR                $HTTP_FASTLY_CLIENT_IP;
    - require:
      - sls: nginx


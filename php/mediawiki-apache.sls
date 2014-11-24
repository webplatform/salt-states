include:
  - apache
  - php.apache

extend:
  apache2:
    service:
      - watch:
        - file: /etc/php5/mods-available/memcached.ini
        - file: /etc/php5/mods-available/apcu.ini

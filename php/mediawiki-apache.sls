include:
  - apache
  - php.apache

extend:
  apache2:
    service:
      - watch:
        - file: /etc/php5/conf.d/apc.ini

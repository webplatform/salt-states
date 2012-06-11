include:
  - php
  - apache

php-mediawiki:
  pkg:
    - latest
    - names:
      - php5-curl
      - php5-mysql
      - php5-xmlrpc
      - php5-intl
      - php5-memcache

/etc/php5/conf.d/apc.ini:
  file.managed:
    - source: salt://php/apc.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-apc

extend:
  apache2:
    service:
      - watch:
        - file: /etc/php5/conf.d/apc.ini

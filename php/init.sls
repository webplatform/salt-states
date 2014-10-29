include:
  - php.composer

php-basic:
  pkg.installed:
    - names:
      - php5-common
      - php-pear
      - php-apc
      - php5-memcached
      - php5-redis
      - php5-intl

/etc/php5/mods-available/apc.ini:
  file.managed:
    - source: salt://php/files/apc.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-apc

/etc/php5/mods-available/memcached.ini:
  file.managed:
    - source: salt://php/files/memcached.ini
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: php5-memcached

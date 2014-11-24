include:
  - php.composer

php-basic-deps:
  pkg.installed:
    - pkgs:
      - php5-common
      - php5-redis
      - php5-memcached
      - php5-intl
      - libpcre3-dev
      - php5-dev
      - php-pear

apcu:
  pecl.installed:
    - name: apcu
    - require:
      - pkg: php-basic-deps

/etc/php5/mods-available/apc.ini:
  file.managed:
    - source: salt://php/files/apc.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pecl: apcu

/etc/php5/mods-available/memcached.ini:
  file.managed:
    - source: salt://php/files/memcached.ini
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: php-basic-deps

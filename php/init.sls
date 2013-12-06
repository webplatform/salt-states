php-basic:
  pkg:
    - latest
    - names:
      - php5-common
      - php5-cli
      - php-pear
      - php-apc
      - php5-memcached
      - php5-memcache

curl:
  pkg:
    - installed

get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -sS https://getcomposer.org/installer | php'
    - unless: test -f /usr/local/bin/composer
    - cwd: /root/
    - require:
      - pkg: php5-cli
      - pkg: curl

install-composer:
  cmd.wait:
    - name: mv /root/composer.phar /usr/local/bin/composer
    - cwd: /root/
    - watch:
      - cmd: get-composer

/etc/php5/conf.d/apc.ini:
  file.managed:
    - source: salt://php/apc.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-apc

/etc/php5/conf.d/memcached.ini:
  file.managed:
    - source: salt://php/memcached.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php5-memcached

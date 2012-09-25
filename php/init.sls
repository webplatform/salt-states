php-basic:
  pkg:
    - latest
    - names:
      - php5-common
      - php5-cli
      - php-pear
      - php-apc
      - php5-memcached

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
	  -pkg: php5-memcached

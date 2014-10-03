include:
  - php.composer

php-basic:
  pkg:
    - latest
    - names:
      - php5-common
      - php-pear
      - php-apc
      - php5-memcached
      - php5-redis
      - php5-intl
      - php-wikidiff2

{% if grains['lsb_distrib_release'] == "14.04" %}
/etc/php5/mods-available/apc.ini:
{% else %}
/etc/php5/conf.d/apc.ini:
{% endif %}
  file.managed:
    - source: salt://php/apc.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-apc

{% if grains['lsb_distrib_release'] == "14.04" %}
/etc/php5/mods-available/memcached.ini:
{% else %}
/etc/php5/conf.d/memcached.ini:
{% endif %}
  file.managed:
    - source: salt://php/memcached.ini
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: php5-memcached

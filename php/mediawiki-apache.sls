include:
  - apache
  - php.apache

extend:
  apache2:
    service:
      - watch:
{% if grains['lsb_distrib_release'] == "14.04" %}
        - file: /etc/php5/mods-available/memcached.ini
        - file: /etc/php5/mods-available/apc.ini
{% else %}
        - file: /etc/php5/conf.d/apc.ini
        - file: /etc/php5/conf.d/memcached.ini
{% endif %}

adjust-memcached-ini:
  file.append:
    - name: /etc/php5/conf.d/memcached.ini
    - text: |
        session.save_path = "localhost:11211"
    - require:
      - pkg: memcached
      - pkg: php5-memcached
      - file: /etc/php5/conf.d/memcached.ini

comment-memcached-ini:
  file.comment:
    - name: /etc/php5/conf.d/memcached.ini
    - regex: ^session.save_path = "memcache(.*)
    - require:
      - file: adjust-memcached-ini


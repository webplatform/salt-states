include:
  - memcached
  - users.randall
  - mysql.server
  - apache.annotation
  - hypothesis
  - java.oracle
  - users.randall

#adjust-memcached-ini:
#  file.append:
#    - name: /etc/php5/conf.d/memcached.ini
#    - text: |
#        session.save_path = "localhost:11211"
#    - requires:
#      - pkg: memcached
#      - pkg: php5-memcached
#      - file: /etc/php5/conf.d/memcached.ini
#
#comment-memcached-ini:
#  file.comment:
#    - name: /etc/php5/conf.d/memcached.ini
#    - regex: ^session.save_path = "memcache(.*)
#    - requires:
#      - file: adjust-memcached-ini

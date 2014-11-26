#
# Ref:
#   - http://infoheap.com/how-to-install-and-monitor-memcache-for-php-on-ubuntu-linux/
#
include:
  - mmonit

memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /etc/memcached.conf
    - require:
      - pkg: memcached

memcached-dependencies:
  pkg.installed:
    - pkgs:
      - libmemcached-tools

/etc/memcached.conf:
  file:
    - managed
    - template: jinja
    - source: salt://memcached/memcached.conf
    - user: root
    - group: root
    - mode: 444

/etc/monit/conf.d/memcached.conf:
  file.managed:
    - source: salt://memcached/files/monit.conf
    - watch_in:
      - service: monit

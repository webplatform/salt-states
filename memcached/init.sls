memcached:
  pkg:
    - latest
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/memcached.conf
    - requires:
      - pkg: memcached

memcached-dependencies:
  pkg.installed:
    pkgs:
      - libmemcached-tools

/etc/memcached.conf:
  file:
    - managed
    - template: jinja
    - source: salt://memcached/memcached.conf
    - user: root
    - group: root
    - mode: 444

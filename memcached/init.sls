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
    - require:
      - service: monit

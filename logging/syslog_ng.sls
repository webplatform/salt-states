syslog-ng:
  pkg.installed

/etc/syslog-ng/conf.d/10local1.conf:
  file.managed:
    - source: salt://logging/10local1.conf
    - user: root
    - group: root
    - mode: 444
    - template: jinja
    - watch_in:
      - service: syslog-ng

/etc/syslog-ng/conf.d/20-caching.conf:
  file.managed:
    - source: salt://logging/20-caching.conf
    - user: root
    - group: root
    - watch_in:
      - service: syslog-ng

syslog-ng:
  pkg.installed

/etc/syslog-ng/conf.d/10local1.conf:
  file.managed:
    - source: salt://syslog/10local1.conf
    - user: root
    - group: root
    - mode: 444
    - template: jinja
    - watch_in:
      - service: syslog-ng

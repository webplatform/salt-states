rsyslog:
  service:
    - running

/etc/rsyslog.d/60-local1.conf:
  file.managed:
    - source: salt://syslog/60-local1.conf
    - user: root
    - group: root
    - mode: 444
    - template: jinja
    - watch_in:
      - service: rsyslog

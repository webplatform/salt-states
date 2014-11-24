syslog-requisites:
  pkg:
    - installed
    - names:
      - syslog-ng-core

syslog-ng:
  service:
    - running

/etc/syslog-ng/conf.d/10-local1.conf:
  file.managed:
    - source: salt://logging/files/10-local1.conf.jinja
    - user: root
    - group: root
    - mode: 444
    - template: jinja
    - watch_in:
      - service: syslog-ng

/etc/syslog-ng/conf.d/20-fastly.conf:
  file.managed:
    - source: salt://logging/files/20-fastly.conf
    - user: root
    - group: root
    - watch_in:
      - service: syslog-ng

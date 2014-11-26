include:
  - mmonit

syslog-ng:
  pkg.installed:
    - name: syslog-ng-core
  service.running:
    - require:
      - pkg: syslog-ng 

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

/etc/monit/conf.d/syslog-ng.conf:
  file.managed:
    - source: salt://logging/files/syslog-ng/monit.conf
    - require:
      - service: syslog-ng
    - watch_in:
      - service: monit

sysstat:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: sysstat
    - watch:
      - file: /etc/default/sysstat
  file.managed:
    - name: /etc/default/sysstat
    - source: salt://sysstat/files/default.conf.jinja
    - template: jinja
    - require:
      - service: sysstat

monit:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: monit
    - watch:
      - file: /etc/monit/conf.d/defaults.conf

/etc/monit/conf.d/defaults.conf:
  file.managed:
    - source: salt://mmonit/files/defaults.conf.jinja
    - template: jinja
    - require:
      - pkg: monit
    - context:
        nodename: {{ grains['fqdn'] }}

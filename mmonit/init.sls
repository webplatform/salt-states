monit:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: monit
      - file: /etc/monit/conf.d
    - watch:
      - file: /etc/monit/conf.d/*

/etc/monit/conf.d/defaults.conf:
  file.managed:
    - source: salt://mmonit/files/defaults.conf.jinja
    - template: jinja
    - require:
      - pkg: monit
      - file: /etc/monit/conf.d
    - context:
        nodename: {{ grains['fqdn'] }}

/etc/monit/conf.d:
  file.directory:
    - file_mode: 700
    - recurse:
      - mode
    - require:
      - pkg: monit
 

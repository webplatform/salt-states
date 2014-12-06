monit:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: monit

/etc/monit/conf.d/defaults.conf:
  file.managed:
    - source: salt://mmonit/files/defaults.conf.jinja
    - template: jinja
    - require:
      - pkg: monit
      - file: /etc/monit/conf.d
    - context:
        nodename: {{ grains['fqdn'] }}
        monit_pw: {{ salt['pillar.get']('accounts:monit:admin_password', 'somethingrandom') }}
        monit_port: 2812

/etc/monit/conf.d:
  file.directory:
    - file_mode: 700
    - recurse:
      - mode
    - require:
      - pkg: monit
    - watch_in:
      - service: monit

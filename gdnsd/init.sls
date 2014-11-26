{%- set level = salt['grains.get']('level', 'production') -%}

include:
  - mmonit

gdnsd:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/gdnsd/zones
  file.recurse:
    - name: /etc/gdnsd/zones
    - source: salt://gdnsd/files/zones/{{ level }}
    - require:
      - pkg: gdnsd

/etc/monit/conf.d/gdnsd.conf:
  file.managed:
    - source: salt://gdnsd/files/monit.conf
    - require:
      - service: gdnsd
    - watch_in:
      - service: monit

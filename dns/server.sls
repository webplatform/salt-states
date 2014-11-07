gdnsd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /etc/gdnsd/zones
  file.recurse:
    - name: /etc/gdnsd/zones
    - source: salt://dns/files/gdnsd/zones/staging
    - require:
      - pkg: gdnsd

gdnsd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/gdnsd/zones

/etc/gdnsd/zones:
  file.recurse:
    - source: salt://dns/files/gdnsd/zones/staging
    - require:
      - pkg: gdnsd

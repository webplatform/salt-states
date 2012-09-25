/etc/hosts:
  file.managed:
    - source: salt://hosts/hosts
    - mode: 444

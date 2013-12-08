/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444

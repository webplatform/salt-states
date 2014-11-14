/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444
    - context:
        level: {{ salt['grains.get']('level', 'production') }}
        hostName: {{ salt['grains.get']('host', 'ubuntu') }}

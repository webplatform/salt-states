gmetad:
  pkg.installed

gmetad_service:
  service.running:
    - name: gmetad
    - require:
      - pkg: gmetad
    - watch:
      - file: /etc/ganglia/gmetad.conf

/etc/ganglia/gmetad.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://monitor/gmetad.conf
    - template: jinja
    - require:
      - pkg: gmetad

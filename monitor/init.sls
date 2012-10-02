ganglia-monitor:
  pkg.installed

ganglia-monitor_service:
  service.running:
    - name: ganglia-monitor
    - require:
      - pkg: ganglia-monitor
    - watch:
      - file: /etc/ganglia/gmond.conf

/etc/ganglia/gmond.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://monitor/gmond.conf
    - template: jinja

ganglia-monitor:
  pkg.installed

ganglia-monitor_service:
  service.running:
    - name: ganglia-monitor
    - require:
      - pkg: ganglia-monitor
    - watch:
      - file: /etc/ganglia/gmond.conf

{% if pillar['ganglia_master'] is defined and pillar['ganglia_master'] %}
{% for cluster,port in pillar['ganglia_clusters'].items() %}
/etc/ganglia/gmond-{{ cluster }}.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://monitor/gmond-recv.conf
    - template: jinja
    - context:
      cluster: {{ cluster }}
      port: {{ port }}
{% endfor %}

/etc/ganglia/conf.d:
  file.directory:
    - makedirs: True

/etc/init.d/ganglia-monitor:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://monitor/ganglia-monitor
    - require:
      - pkg: ganglia-monitor

extend:
  ganglia-monitor_service:
    service:
      - watch:
        - file: /etc/init.d/ganglia-monitor
{% endif %}

/etc/ganglia/gmond.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://monitor/gmond.conf
    - template: jinja

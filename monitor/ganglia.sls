{% set ganglia = salt['pillar.get']('ganglia') %}
{% set port = ganglia.clusters.get(ganglia.group, 'app') %}
{% set level = salt['grains.get']('level', 'production') %}

ganglia-monitor:
  pkg:
    - installed
  service:
    - running

/etc/ganglia/conf.d:
  file.directory:
    - makedirs: True

/etc/ganglia/gmond.conf:
  file.managed:
    - source: salt://monitor/files/ganglia/gmond.conf.jinja
    - template: jinja
    - mode: 644
    - context:
        port: {{ port }}
        level: {{ level }}
    - watch_in:
      - service: ganglia-monitor
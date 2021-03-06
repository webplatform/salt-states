{%- set level = salt['grains.get']('level', 'production') -%}
{%- set elasticsearch_nodes = salt['pillar.get']('infra:elasticsearch:nodes', ['127.0.0.1']) %}
{%- set hosts_entries = salt['pillar.get']('infra:hosts_entries', []) %}

include:
  - mmonit

gdnsd:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
  file.managed:
    - name: /etc/gdnsd/zones/{{ level }}.wpdn
    - source: salt://gdnsd/files/zonefile.wpdn.jinja
    - template: jinja
    - require:
      - pkg: gdnsd
    - watch_in:
      - service: gdnsd
    - context:
        gdnsd_timestamp: {{ salt['pillar.get']('infra:gdnsd_timestamp', '2014121200') }}
        level: {{ level }}
        hosts_entries: {{ hosts_entries }}
        elasticsearch_nodes: {{ elasticsearch_nodes }}

/etc/monit/conf.d/gdnsd.conf:
  file.managed:
    - source: salt://gdnsd/files/monit.conf
    - require:
      - service: gdnsd
    - watch_in:
      - service: monit

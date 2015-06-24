{% set defaultObj = {'group':'app', 'clusters': {'app':8600}} %}
{% set ganglia = salt['pillar.get']('ganglia', defaultObj) %}
{% set port = ganglia.clusters.get(ganglia.group, 8600) %}
{% set clusters = ganglia.clusters %}
{% set level = salt['grains.get']('level', 'production') %}
{% set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') %}

include:
  - .ganglia

ganglia-webfrontend:
  pkg.installed

gmetad:
  pkg:
    - installed
  service:
    - running

/etc/ganglia/gmetad.conf:
  file.managed:
    - source: salt://monitor/files/ganglia/gmetad.conf.jinja
    - template: jinja
    - mode: 644
    - watch_in:
      - service: gmetad
    - context:
        clusters: {{ clusters }}
        tld: {{ tld }}

{% for cluster,port in clusters.items() %}
/etc/ganglia/gmond-{{ cluster }}.conf:
  file.managed:
    - source: salt://monitor/files/ganglia/gmond-recv.conf.jinja
    - template: jinja
    - mode: 644
    - context:
        cluster: {{ cluster }}
        port: {{ port }}

/etc/init/gmond-{{ cluster }}.conf:
  file.managed:
    - source: salt://monitor/files/ganglia/gmond.init.jinja
    - template: jinja
    - mode: 644
    - context:
        cluster: {{ cluster }}

{% endfor %}

/etc/apache2/conf-enabled/ganglia-webfrontend.conf:
  file.symlink:
    - target: /etc/ganglia-webfrontend/apache.conf


{%- set level = salt['grains.get']('level', 'production') -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set backend_port = salt['pillar.get']('infra:backends:port:status', 8000) -%}
{%- set backends = salt['pillar.get']('infra:status:backends', ['127.0.0.1']) %}

include:
  - nginx

/etc/nginx/sites-available/monitor:
  file.managed:
    - source: salt://monitor/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        backend_port: {{ backend_port }}
        backends: {{ backends }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-monitor:
  file.symlink:
    - target: /etc/nginx/sites-available/monitor
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/monitor


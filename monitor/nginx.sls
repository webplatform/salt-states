{%- set level = salt['grains.get']('level', 'production') -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set host = salt['pillar.get']('infra:monitor:docker_host') -%}
{%- set port = salt['pillar.get']('infra:monitor:docker_port') -%}
include:
  - nginx

/etc/nginx/sites-available/monitor:
  file.managed:
    - source: salt://monitor/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        monitor_docker_port: {{ port }}
        monitor_docker_host: {{ host }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-monitor:
  file.symlink:
    - target: /etc/nginx/sites-available/monitor
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/monitor


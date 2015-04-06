{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set backend_port = salt['pillar.get']('infra:backends:port:project', 8003) -%}
{%- set backends = salt['pillar.get']('infra:project:backends', ['127.0.0.1']) %}

include:
  - nginx

/etc/nginx/sites-available/project:
  file.managed:
    - source: salt://buggenie/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        backends: {{ backends }}
        backend_port: {{ backend_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-project:
  file.symlink:
    - target: /etc/nginx/sites-available/project
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/project


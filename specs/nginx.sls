{%- set tld                   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set backend_port_publican = salt['pillar.get']('infra:backends:port:publican', 8002) -%}
{%- set backends_publican     = salt['pillar.get']('infra:publican:backends', ['127.0.0.1']) %}

include:
  - nginx

/etc/nginx/sites-available/specs:
  file.managed:
    - source: salt://specs/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        backends_publican: {{ backends_publican }}
        backend_port_publican: {{ backend_port_publican }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/10-specs:
  file.symlink:
    - target: /etc/nginx/sites-available/specs
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/specs
    - watch_in:
      - service: nginx


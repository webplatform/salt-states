{%- set level = salt['grains.get']('level', 'production') -%}
{%- set port  = salt['pillar.get']('infra:notes-server:port', 8001) -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
include:
  - nginx.local

/etc/nginx/sites-available/local.notes:
  file.managed:
    - source: salt://hypothesis/files/nginx.local.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        hypothesis_port: {{ port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/local.notes:
  file.symlink:
    - target: /etc/nginx/sites-available/local.notes
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/local.notes


{%- set tld = salt['grains.get']('infra:current:tld', 'webplatform.org') -%}
include:
  - nginx

/etc/nginx/sites-available/webplatform:
  file.managed:
    - source: salt://nginx/files/default.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/00-webplatform:
  file.symlink:
    - target: /etc/nginx/sites-available/webplatform
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/webplatform


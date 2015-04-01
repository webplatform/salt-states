{%- set level = salt['grains.get']('level', 'production') -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
include:
  - nginx

/etc/nginx/sites-available/notes:
  file.managed:
    - source: salt://hypothesis/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        subDomainName: notes
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-notes:
  file.symlink:
    - target: /etc/nginx/sites-available/notes
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/notes


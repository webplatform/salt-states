{%  set level = salt['grains.get']('level', 'production') -%}
{%- set port  = salt['pillar.get']('infra:stats-server:port', 9000) -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') %}

include:
  - nginx.local
  - piwik

/etc/nginx/sites-available/local.stats:
  file.managed:
    - source: salt://piwik/files/nginx.local.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        piwik_port: {{ port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/local.stats:
  file.symlink:
    - target: /etc/nginx/sites-available/local.stats
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/local.stats


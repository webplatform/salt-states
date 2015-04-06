{%  set level = salt['grains.get']('level', 'production') -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') %}
{#
 # Piwik Salt stack config
 #
 # See also:
 #   - https://github.com/perusio/piwik-nginx.git
 #}
include:
  - nginx

/etc/nginx/sites-available/stats:
  file.managed:
    - source: salt://piwik/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/10-stats:
  file.symlink:
    - target: /etc/nginx/sites-available/stats
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/stats


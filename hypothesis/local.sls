{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set hypothesis_port = salt['pillar.get']('infra:notes-server:port', 8001) -%}
{%- set upstream_port = salt['pillar.get']('upstream:hypothesis:port', 8005) %}

include:
  - .
  - .fxa_and_h_ssl_issue
  - nginx.local

#
# This is the LOCAL virtual host state manager, this state is responsible to
# expose a basic HTTP server so that the frontend servers can proxy through it.
#

/etc/nginx/sites-available/local.notes:
  file.managed:
    - source: salt://hypothesis/files/nginx.local.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstream_port: {{ upstream_port }}
        hypothesis_port: {{ hypothesis_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/local.notes:
  file.symlink:
    - target: /etc/nginx/sites-available/local.notes
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/local.notes


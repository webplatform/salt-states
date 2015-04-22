{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstream_port = salt['pillar.get']('upstream:hypothesis:port', 8005) -%}
{%- set upstreams = salt['pillar.get']('upstream:hypothesis:nodes', ['127.0.0.1']) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **notes** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/notes:
  file.managed:
    - source: salt://hypothesis/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstream_port: {{ upstream_port }}
        upstreams: {{ upstreams }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-notes:
  file.symlink:
    - target: /etc/nginx/sites-available/notes
    - require:
      - file: /etc/nginx/sites-available/notes


{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams = salt['pillar.get']('upstream:buggenie:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:buggenie:port', 8007) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **project** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/project:
  file.managed:
    - source: salt://buggenie/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-project:
  file.symlink:
    - target: /etc/nginx/sites-available/project
    - require:
      - file: /etc/nginx/sites-available/project


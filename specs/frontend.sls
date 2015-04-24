{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams_publican = salt['pillar.get']('upstream:publican:nodes', ['127.0.0.1']) -%}
{%- set upstream_port_publican = salt['pillar.get']('upstream:publican:port', 8002) -%}
{%- set upstreams = salt['pillar.get']('upstream:specs:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:specs:port', 8003) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **specs** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/specs:
  file.managed:
    - source: salt://specs/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams_publican: {{ upstreams_publican }}
        upstream_port_publican: {{ upstream_port_publican }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-specs:
  file.symlink:
    - target: /etc/nginx/sites-available/specs
    - require:
      - file: /etc/nginx/sites-available/specs


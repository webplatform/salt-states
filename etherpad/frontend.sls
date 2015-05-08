{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams = salt['pillar.get']('upstream:etherpad:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:etherpad:port', 8006) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **etherpad** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/etherpad:
  file.managed:
    - source: salt://etherpad/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-etherpad:
  file.symlink:
    - target: /etc/nginx/sites-available/etherpad
    - require:
      - file: /etc/nginx/sites-available/etherpad


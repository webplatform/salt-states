{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams = salt['pillar.get']('upstream:cachet:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:cachet:port', 8000) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **stats** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/monitor:
  file.managed:
    - source: salt://monitor/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-monitor:
  file.symlink:
    - target: /etc/nginx/sites-available/monitor
    - require:
      - file: /etc/nginx/sites-available/monitor


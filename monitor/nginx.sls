{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set backends = salt['pillar.get']('upstream:cachet:nodes', ['127.0.0.1']) -%}
{%- set backend_port = salt['pillar.get']('upstream:cachet:port', 8000) %}

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
    - source: salt://monitor/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        backends: {{ backends }}
        backend_port: {{ backend_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-monitor:
  file.symlink:
    - target: /etc/nginx/sites-available/monitor
    - require:
      - file: /etc/nginx/sites-available/monitor


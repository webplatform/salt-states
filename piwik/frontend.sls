{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams = salt['pillar.get']('upstream:piwik:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:piwik:port', 8004) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **stats** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#
# See also:
#   - https://github.com/perusio/piwik-nginx.git
#

/etc/nginx/sites-available/stats:
  file.managed:
    - source: salt://piwik/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-stats:
  file.symlink:
    - target: /etc/nginx/sites-available/stats
    - require:
      - file: /etc/nginx/sites-available/stats


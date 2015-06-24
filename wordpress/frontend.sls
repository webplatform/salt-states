{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams = salt['pillar.get']('upstream:wordpress:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:wordpress:port', 8007) %}

include:
  - nginx

#
# This is the PUBLIC virtual host for **blog** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/blog:
  file.managed:
    - source: salt://wordpress/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-blog:
  file.symlink:
    - target: /etc/nginx/sites-available/blog
    - require:
      - file: /etc/nginx/sites-available/blog


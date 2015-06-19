{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set mail_ip = salt['pillar.get']('infra:hosts_entries:mail', '127.0.0.1') -%}
{%- set monitor_ip = salt['pillar.get']('infra:hosts_entries:monitor', '127.0.0.1') -%}
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

/etc/nginx/htpasswd:
  file.managed:
    - contents: |
        {{ salt['pillar.get']('accounts:monitor_htpasswd', [])|join("\n") }}
    - contents_newline: True

/etc/nginx/sites-available/monitor:
  file.managed:
    - source: salt://monitor/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
        mail_ip: {{ mail_ip }}
        monitor_ip: {{ monitor_ip }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-monitor:
  file.symlink:
    - target: /etc/nginx/sites-available/monitor
    - require:
      - file: /etc/nginx/sites-available/monitor


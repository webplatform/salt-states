{%- set tld = salt['grains.get']('infra:current:tld', 'webplatform.org') -%}

include:
  - nginx

#
# This is the PUBLIC virtual host for **(|www)** subdomain proxying requests
# to an internal webserver.
#
# ===========================================================================
#

/etc/nginx/sites-available/webplatform:
  file.managed:
    - source: salt://webplatform/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/00-webplatform:
  file.symlink:
    - target: /etc/nginx/sites-available/webplatform
    - require:
      - file: /etc/nginx/sites-available/webplatform


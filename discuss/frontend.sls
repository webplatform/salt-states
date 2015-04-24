{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstreams = salt['pillar.get']('upstream:discourse:nodes', ['127.0.0.1']) -%}
{%- set upstream_port = salt['pillar.get']('upstream:discourse:port', 8000) %}

include:
  - nginx

/etc/nginx/sites-available/discuss:
  file.managed:
    - source: salt://discuss/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstreams: {{ upstreams }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-discuss:
  file.symlink:
    - target: /etc/nginx/sites-available/discuss
    - require:
      - file: /etc/nginx/sites-available/discuss


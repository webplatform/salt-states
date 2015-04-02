{%- set level = salt['grains.get']('level', 'production') -%}
{%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set host = salt['pillar.get']('infra:discuss:docker_host') -%}
{%- set port = salt['pillar.get']('infra:discuss:docker_port') -%}
include:
  - nginx

/etc/nginx/sites-available/discuss:
  file.managed:
    - source: salt://discuss/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        discuss_docker_port: {{ port }}
        discuss_docker_host: {{ host }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-discuss:
  file.symlink:
    - target: /etc/nginx/sites-available/discuss
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/discuss


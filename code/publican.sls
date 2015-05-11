{%- set dir = '/srv/webplatform/publican' -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set upstream_port = salt['pillar.get']('upstream:publican:port', 8002) %}

include:
  - users.app-user

{{ dir }}:
  file.directory:
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group

{{ dir }}/data:
  file.directory:
    - user: app-user
    - group: app-user

{{ dir }}/spec-data:
  file.directory:
    - user: app-user
    - group: app-user

{{ dir }}/docker-compose.yml:
  file.managed:
    - source: salt://code/files/publican/docker-compose.yml.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - context:
        upstream_port: {{ upstream_port }}
        salt_master_ip: {{ salt_master_ip }}
    - require:
      - file: {{ dir }}


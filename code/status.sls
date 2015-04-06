{%- set dir = '/srv/webplatform/status' -%}
{%- set backend_port = salt['pillar.get']('infra:backends:port:status', 8000) -%}
{%- set db_creds = salt['pillar.get']('accounts:status:db') -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set masterdb_ip = salt['pillar.get']('infra:hosts_entries:masterdb') %}

include:
  - users.app-user

{{ dir }}:
  file.directory:
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group

{{ dir }}/docker-compose.yml:
  file.managed:
    - source: salt://code/files/status/docker-compose.yml.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - context:
        backend_port: {{ backend_port }}
        db_creds: {{ db_creds }}
        salt_master_ip: {{ salt_master_ip }}
        masterdb_ip: {{ masterdb_ip }}
        smtp: {{ smtp }}
    - require:
      - file: {{ dir }}

{{ dir }}/Dockerfile:
  file.managed:
    - source: salt://code/files/status/Dockerfile
    - user: app-user
    - group: www-data
    - mode: 644
    - require:
      - file: {{ dir }}


{%- set dir = '/srv/webapps/status' -%}
{%- set upstream_port = salt['pillar.get']('upstream:cachet:port', 8000) -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set masterdb_ip = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') -%}
{%- set db_creds = salt['pillar.get']('accounts:status:db') %}

{%- set mysql_user = salt['pillar.get']( 'mysql:user:%s' % db_creds.username ) -%}
{%- if mysql_user.password -%}
{%- do db_creds.update(mysql_user) -%}
{%- endif %}

{{ dir }}:
  file.directory:
    - user: webapps
    - group: webapps
    - recurse:
      - user
      - group

{{ dir }}/docker-compose.yml:
  file.managed:
    - source: salt://code/files/status/docker-compose.yml.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - mode: 644
    - context:
        upstream_port: {{ upstream_port }}
        db_creds: {{ db_creds }}
        salt_master_ip: {{ salt_master_ip }}
        masterdb_ip: {{ masterdb_ip }}
        smtp: {{ smtp }}

{{ dir }}/Dockerfile:
  file.managed:
    - source: salt://code/files/status/Dockerfile
    - user: webapps
    - group: webapps
    - mode: 644

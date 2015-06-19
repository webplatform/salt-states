{%- set accounts_pillar = salt['pillar.get']('accounts:auth-server') -%}
{%- set infra_pillar = salt['pillar.get']('infra:auth-server') -%}
{%- set masterdb_ip = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set oauth_clients = salt['pillar.get']('accounts:auth-server:oauth:clients', []) -%}
{%- set mysql_user = salt['pillar.get']( 'mysql:user:accounts' ) %}

include:
  - code.prereq
{# We need code.certificates them because we will override hostnames within network #}
  - code.certificates

{% set unpack = salt['pillar.get']('basesystem:auth:unpacker_archives') %}
{% from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}
{{ unpack_remote_loop(unpack)}}

{% set configFiles = [
        ('profile', 'config/prod.json'),
        ('oauth',   'config/prod.json'),
        ('content', 'server/config/production.json'),
        ('auth',    'config/prod.json') ] %}
{% for appName, file in configFiles %}
/srv/webplatform/auth-server/{{ appName }}:
  file.directory:
    - makedirs: True
    - user: webapps
    - group: webapps
    - require:
      - file: Packager unpack /srv/webplatform/auth-server/{{ appName }}
    - recurse:
      - user
      - group

/srv/webplatform/auth-server/{{ appName }}/{{ file }}:
  file.managed:
    - source: salt://code/files/auth-server/fxa-{{ appName }}-server.json.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - create: False
    - context:
        accounts_pillar: {{ accounts_pillar }}
        mysql_user: {{ mysql_user }}
        infra_pillar: {{ infra_pillar }}
        masterdb_ip: {{ masterdb_ip }}
        tld: {{ tld }}
        oauth_clients: {{ oauth_clients }}
    - require:
      - file: Packager unpack /srv/webplatform/auth-server/{{ appName }}

{% endfor %}

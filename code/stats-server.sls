{%- set db_creds = salt['pillar.get']('accounts:piwik:db') -%}
{%- set masterdb_ip   = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') -%}

{%- set mysql_user = salt['pillar.get']( 'mysql:user:%s' % db_creds.username ) -%}
{%- if mysql_user.password -%}
{%- do db_creds.update(mysql_user) -%}
{%- endif %}

include:
  - code.prereq
{# We should make everything use webapps instead of app-user #TODO #}
  - users.app-user

{% set unpack = salt['pillar.get']('basesystem:stats:unpacker_archives') %}
{% from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}
{{ unpack_remote_loop(unpack)}}

/srv/webplatform/stats-server:
  file.directory:
    - user: app-user
    - group: www-data
    - require:
      - file: Packager unpack /srv/webplatform/stats-server
      - user: app-user
    - recurse:
      - user
      - group

/srv/webplatform/stats-server/config/config.ini.php:
  file.managed:
    - source: salt://code/files/stats-server/config.ini.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - makedirs: True
    - context:
        masterdb_ip: {{ masterdb_ip }}
        db_creds: {{ db_creds }}
    - require:
      - file: Packager unpack /srv/webplatform/stats-server

/srv/webplatform/stats-server/bootstrap.php:
  file.managed:
    - source: salt://code/files/stats-server/bootstrap.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - require:
      - file: Packager unpack /srv/webplatform/stats-server

{%- set fastly_cidrs = salt['pillar.get']('fastly:cidrs', []) -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set elastic_nodes_wiki = salt['pillar.get']('infra:elasticsearch:nodes-wiki') -%}
{%- set alpha_memcache = salt['pillar.get']('infra:alpha_memcache') -%}
{%- set alpha_redis = salt['pillar.get']('infra:alpha_redis') -%}
{%- set sessions_redis = salt['pillar.get']('infra:sessions_redis') -%}
{%- set swift_backend = salt['pillar.get']('accounts:wiki:swift') %}
{%- set swift_creds = salt['pillar.get']('accounts:swift:dreamhost') %}
{%- set db_creds = salt['pillar.get']('accounts:wiki:db') -%}
{%- set secrets = salt['pillar.get']('accounts:wiki:secrets') -%}
{%- set db_servers    = salt['pillar.get']('infra:db_servers:mysql:slaves', []) -%}
{%- set masterdb_ip   = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') %}

{%- set mysql_user = salt['pillar.get']( 'mysql:user:%s' % db_creds.username ) -%}
{%- if mysql_user.password -%}
{%- do db_creds.update(mysql_user) -%}
{%- endif %}

include:
  - code.prereq

{% set unpack = salt['pillar.get']('basesystem:app:unpacker_archives') %}
{% from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}
{{ unpack_remote_loop(unpack)}}

/srv/webplatform/wiki/Settings.php:
  file.managed:
    - source: salt://code/files/wiki/Settings.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data

{% set envNames = ['wpwiki','wptestwiki'] %}
{% for env in envNames %}

/srv/webplatform/wiki/{{ env }}/mediawiki/LocalSettings.php:
  file.managed:
    - source: salt://code/files/wiki/LocalSettings.php.jinja
    - template: jinja
    - context:
        elastic_nodes_wiki:  {{ elastic_nodes_wiki }}
        alpha_memcache: {{ alpha_memcache }}
        alpha_redis:    {{ alpha_redis }}
        sessions_redis: {{ sessions_redis }}
        fastly_cidrs: {{ fastly_cidrs }}
        tld: {{ tld }}
        level: {{ level }}

/srv/webplatform/wiki/{{ env }}/cache:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/{{ env }}/logs:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/{{ env }}/LocalSettings.php:
  file.managed:
    - source: salt://code/files/wiki/{{ env }}.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - context:
        swift_backend: {{ swift_backend }}
        db_servers: {{ db_servers }}
        db_creds: {{ db_creds }}
        secrets: {{ secrets }}
        swift_creds: {{ swift_creds }}
        masterdb_ip: {{ masterdb_ip }}

{% endfor %}

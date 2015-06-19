{%- set elastic_nodes_wiki = salt['pillar.get']('infra:elasticsearch:nodes-wiki') -%}
{%- set alpha_memcache = salt['pillar.get']('infra:alpha_memcache') -%}
{%- set alpha_redis = salt['pillar.get']('infra:alpha_redis') -%}
{%- set sessions_redis = salt['pillar.get']('infra:sessions_redis') -%}
{%- set swift_backend = salt['pillar.get']('accounts:wiki:swift') %}

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
        elastic_nodes_wiki:  {{ elastic_nodes_wiki }}
        swift_backend: {{ swift_backend }}

{% endfor %}

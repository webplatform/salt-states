{%- set elastic_nodes_wiki = salt['pillar.get']('infra:elasticsearch:nodes-wiki') -%}
{%- set alpha_memcache = salt['pillar.get']('infra:alpha_memcache') -%}
{%- set alpha_redis = salt['pillar.get']('infra:alpha_redis') -%}
{%- set sessions_redis = salt['pillar.get']('infra:sessions_redis') -%}
# Include the common settings for the docs repo
include:
  - code.prereq
  - rsync.secret
  - users.app-user

{%- set envNames = ['wpwiki','wptestwiki'] -%}

{% for env in envNames %}

/srv/webplatform/wiki/{{ env }}:
  file.directory:
    - makedirs: True

/srv/webplatform/wiki/{{ env }}/mediawiki/mirror.php:
  file.managed:
    - source: salt://code/files/wiki/mirror.php
    - require:
      - cmd: rsync-run-{{ env }}

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
    - require:
      - file: /srv/webplatform/wiki/{{ env }}
    - recurse:
      - user
      - group

/srv/webplatform/wiki/{{ env }}/logs:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/webplatform/wiki/{{ env }}
    - recurse:
      - user
      - group

/srv/webplatform/wiki/{{ env }}/local.d:
  file.recurse:
    - source: salt://code/files/wiki/{{ env }}
    - require:
      - file: /srv/webplatform/wiki/{{ env }}

# @salt-master-dest
rsync-run-{{ env }}:
  cmd.run:
    - name: "rsync -a --exclude '.git' --exclude '.svn' --exclude 'LocalSettings.php' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/wiki/repo/ /srv/webplatform/wiki/{{ env }}/"
    - user: root
    - group: root
    - require_in:
      - file: /srv/webplatform/wiki/{{ env }}/cache
      - file: /srv/webplatform/wiki/{{ env }}/mediawiki/LocalSettings.php
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: /srv/webplatform/wiki/{{ env }}
  file.managed:
    - name: /srv/webplatform/wiki/{{ env }}/LocalSettings.php
    - source: salt://code/files/wiki/{{ env }}.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - context:
        elastic_nodes_wiki:  {{ elastic_nodes_wiki }}
    - require:
      - file: /srv/webplatform/wiki/Settings.php

{% endfor %}

/srv/webplatform/wiki/Settings.php:
  file.managed:
    - source: salt://code/files/wiki/Settings.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data

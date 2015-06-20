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
  - rsync.secret

/srv/webplatform/wiki/wpwiki:
  file.directory:
    - makedirs: True

# @salt-master-dest
rsync-run-wpwiki:
  cmd.run:
    - name: "rsync -a --exclude '.git' --exclude '.svn' --exclude 'LocalSettings.php' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/wiki/repo/ /srv/webplatform/wiki/wpwiki/"
    - stateful: True
    - user: root
    - group: root
    - require_in:
      - file: /srv/webplatform/wiki/wpwiki/cache
      - file: /srv/webplatform/wiki/wpwiki/mediawiki/LocalSettings.php
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

/srv/webplatform/wiki/Settings.php:
  file.managed:
    - source: salt://code/files/wiki/Settings.php.jinja
    - template: jinja
    - createdirs: True
    - user: www-data
    - group: www-data

/srv/webplatform/wiki/wpwiki/mediawiki/LocalSettings.php:
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

/srv/webplatform/wiki/wpwiki/cache:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/wpwiki/logs:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/wpwiki/LocalSettings.php:
  file.managed:
    - source: salt://code/files/wiki/wpwiki.php.jinja
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


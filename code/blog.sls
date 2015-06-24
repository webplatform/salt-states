{%- set masterdb_ip = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') -%}
{%- set db_creds = salt['pillar.get']('accounts:blog:db') %}
{%- set alpha_memcache = salt['pillar.get']('infra:alpha_memcache') -%}

{%- set mysql_user = salt['pillar.get']( 'mysql:user:%s' % db_creds.username ) -%}
{%- if mysql_user.password -%}
{%- do db_creds.update(mysql_user) -%}
{%- endif %}

include:
  - rsync.secret
  - code.prereq

/srv/webplatform/blog/robots.txt:
  file.managed:
    - source: salt://code/files/blog/robots.txt
    - user: www-data
    - group: www-data
    - require:
      - cmd: rsync-blog

# @salt-master-dest
# do not put --delete in rsync. Otherwise it deletes images uploads and config caches too
rsync-blog:
  cmd.run:
    - name: "rsync -a  --exclude '.git' --no-perms --password-file=/etc/codesync.secret codesync@salt::code/blog/repo/ /srv/webplatform/blog/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/blog
    - user: www-data
    - group: www-data
    - file_mode: 644
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode

# @salt-master-dest
# Refer to rsync/init.sls
wp-content-uploads:
  cmd.run:
    - name: "rsync -az --no-perms --password-file=/etc/codesync.secret /srv/webplatform/blog/wp-content/uploads/ codesync@salt::wp-content-uploads/"
    - user: root
    - group: root
    - onlyif: test -d /srv/webplatform/blog/wp-content/uploads/
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

/srv/webplatform/blog/local.php:
  file.managed:
    - source: salt://code/files/blog/local.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - context:
        db_creds: {{ db_creds }}
        masterdb_ip: {{ masterdb_ip }}
        alpha_memcache: {{ alpha_memcache }}

/srv/webplatform/blog/wp-content/cache:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: www-data

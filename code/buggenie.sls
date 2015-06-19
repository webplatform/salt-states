{%- set db_creds      = salt['pillar.get']('accounts:buggenie:db') %}
{%- set masterdb_ip   = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') %}
{%- set tld           = salt['pillar.get']('infra:current:tld', 'webplatform.org') %}

{%- set mysql_user = salt['pillar.get']( 'mysql:user:%s' % db_creds.username ) -%}
{%- if mysql_user.password -%}
{%- do db_creds.update(mysql_user) -%}
{%- endif %}

include:
  - rsync.secret
  - code.prereq
  - php.buggenie

# @salt-master-dest
buggenie-codesync:
  cmd.run:
    - name: "rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/buggenie/repo/ /srv/webplatform/buggenie/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

/srv/webplatform/buggenie/installed:
  file.managed:
    - source: salt://code/files/buggenie/installed

/srv/webplatform/buggenie:
  file.directory:
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
    - require_in:
      - file: /srv/webplatform/buggenie/core/cache

/srv/webplatform/buggenie/core/cache:
  file.directory:
    - makedirs: True

/srv/webplatform/buggenie/core:
  file.directory:
    - user: www-data
    - group: www-data

/srv/webplatform/buggenie/core/b2db_bootstrap.inc.php:
  file.managed:
    - source: salt://code/files/buggenie/b2db_bootstrap.inc.php.jinja
    - template: jinja
    - user: nobody
    - group: www-data
    - context:
        db_creds: {{ db_creds }}
        masterdb_ip: {{ masterdb_ip }}
        tld: {{ tld }}

/var/www/robots.txt:
  file.managed:
    - source: salt://buggenie/files/robots.txt
    - user: www-data
    - group: www-data


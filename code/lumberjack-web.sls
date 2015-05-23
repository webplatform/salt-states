{%- set db_creds = salt['pillar.get']('accounts:lumberjack:db') -%}
{%- set masterdb_ip = salt['pillar.get']('infra:db_servers:mysql:writes', '127.0.0.1') %}

include:
  - code.prereq
  - rsync.secret

# @salt-master-dest
rsync-lumberjack-web:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/bots/repo/web/ /srv/webplatform/lumberjack-web/"
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/lumberjack-web
  file.directory:
    - name: /srv/webplatform/lumberjack-web
    - user: www-data
    - group: www-data
    - makedirs: True
    - file_mode: 644
    - dir_mode: 755
    - require:
      - file: webplatform-sources
    - recurse:
      - user
      - group
      - mode

/srv/webplatform/lumberjack-web/config.php:
  file.managed:
    - source: salt://code/files/lumberjack/config.php.jinja
    - template: jinja
    - context:
        db_creds:    {{ db_creds }}
        masterdb_ip: {{ masterdb_ip }}
    - user: www-data
    - group: www-data
    - require:
      - cmd: rsync-lumberjack-web


include:
  - rsync.secret
  - code.prereq

/srv/webplatform/lumberjack-listener:
  file.directory:
    - mode: 755
    - makedirs: True
    - require:
      - file: webplatform-sources

# @salt-master-dest
lumberjack-listener-rsync:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/bots/repo/listener/ /srv/webplatform/lumberjack-listener/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: /srv/webplatform/lumberjack-listener
  file.directory:
    - name: /srv/webplatform/lumberjack-listener
    - user: www-data
    - group: www-data
    - file_mode: 644
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode

chmod 755 /srv/webplatform/lumberjack-listener/LumberJack.py:
  cmd.run:
    - require:
      - file: lumberjack-listener-rsync

/srv/webplatform/lumberjack-listener/mysql_config.txt:
  file.managed:
    - source: salt://code/files/lumberjack/mysql_config.txt.jinja
    - template: jinja
    - context:
        db_creds:    {{ salt['pillar.get']('accounts:lumberjack:db') }}
        masterdb_ip: {{ salt['pillar.get']('infra:db_servers:mysql:masterdb', '127.0.0.1') }}
    - require:
      - cmd: lumberjack-listener-rsync

/srv/webplatform/lumberjack-listener/irc_config.txt:
  file.managed:
    - source: salt://code/files/lumberjack/irc_config.txt.jinja
    - template: jinja
    - require:
      - cmd: lumberjack-listener-rsync


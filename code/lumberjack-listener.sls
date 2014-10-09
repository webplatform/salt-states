include:
  - rsync.secret
  - code.prereq

/srv/webplatform/lumberjack-listener:
  file.directory:
    - mode: 755
    - makedirs: True
    - require:
      - file: /srv/webplatform

lumberjack-listener-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/bots/lumberjack/repo/listener/ /srv/webplatform/lumberjack-listener/"
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/lumberjack-listener
  file:
    - directory
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
  cmd:
    - run
    - require:
      - file: lumberjack-listener-rsync

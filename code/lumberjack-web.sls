include:
  - rsync.secret
  - code.prereq
  - bots.lumberjack-web

extend:
  /srv/webplatform/lumberjack-web:
    file.directory:
      - mode: 755
      - makedirs: True
      - require:
        - file: webplatform-sources

lumberjack-web-rsync:
  cmd:
    - wait
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/bots/lumberjack/repo/web/ /srv/webplatform/lumberjack-web/"
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/lumberjack-web
  file:
    - directory
    - name: /srv/webplatform/lumberjack-web
    - user: www-data
    - group: www-data
    - file_mode: 644
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode

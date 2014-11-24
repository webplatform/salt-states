include:
  - code.prereq
  - rsync.secret

extend:
  /srv/webplatform/lumberjack-web:
    file.directory:
      - mode: 755
      - makedirs: True
      - require:
        - file: webplatform-sources

# @salt-master-dest
lumberjack-web-rsync:
  cmd:
    - wait
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/bots/repo/web/ /srv/webplatform/lumberjack-web/"
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

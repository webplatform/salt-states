include:
  - rsync.secret
  - code.prereq

lumberjack-config:
  file.managed:
    - name: /srv/webplatform/lumberjack-web/config.php
    - template: jinja
    - user: nobody
    - group: deployment
    - source: salt://code/files/lumberjack/config.php.jinja
    - require:
      - cmd: lumberjack-rsync

lumberjack-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.wpdn::code/bots/lumberjack/repo/web/ /srv/webplatform/lumberjack-web/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/lumberjack-web

/srv/webplatform/lumberjack-web:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data

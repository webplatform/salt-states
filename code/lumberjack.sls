include:
  - rsync.secret
  - code.prereq

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/bots/lumberjack/ /srv/webplatform/bots/lumberjack/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
  file.managed:
    - name: /srv/webplatform/bots/lumberjack/config.php
    - user: nobody
    - group: deployment
    - source: salt://code/files/lumberjack/config.php

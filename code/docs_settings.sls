include:
  - rsync.secret

rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/docs/Settings.php /srv/webplatform/wiki/Settings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret

rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/docs/JobSettings.php /srv/webplatform/wiki/JobSettings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret


rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/docs/TestSettings.php /srv/webplatform/wiki/test/LocalSettings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret

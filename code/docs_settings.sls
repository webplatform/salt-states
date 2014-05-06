include:
  - rsync.secret

rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/Settings.php /srv/webplatform/wiki/Settings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret

rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/CurrentSettings.php /srv/webplatform/wiki/CurrentSettings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret


rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/TestSettings.php /srv/webplatform/wiki/test/LocalSettings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret

rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/UpgradeSettings.php /srv/webplatform/wiki/UpgradeSettings.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret

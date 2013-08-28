include:
  - rsync.secret
  - code.prereq

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/piwik/piwik/ /srv/webplatform/piwik/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/piwik/config/config.ini.php /srv/webplatform/piwik/config/config.ini.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

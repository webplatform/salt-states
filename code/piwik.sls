include:
  - rsync.secret
  - code.prereq

sync-piwik:
  cmd.run:
    - name: rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/piwik/clone/ /srv/webplatform/piwik/
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
  file.managed:
    - name: /srv/webplatform/piwik/config/config.ini.php
    - user: www-data
    - group: www-data
    - mode: 644
    - source: salt://piwik/config.ini.php

piwik-perms:
  file.directory:
    - name: /srv/webplatform/piwik
    - user: www-data
    - group: www-data
    - wait:
      - pkg: sync-piwik
    - recurse:
      - user
      - group

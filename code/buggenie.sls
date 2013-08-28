include:
  - rsync.secret
  - php.buggenie
  - code.prereq

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/buggenie/ /srv/webplatform/buggenie/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

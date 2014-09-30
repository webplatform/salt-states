include:
  - rsync.secret
  - code.prereq

rsync -a --exclude '.git' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.wpdn::code/dabblet/ /srv/webplatform/dabblet/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

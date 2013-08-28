include:
  - rsync.secret
  - code.prereq

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/kuma/ /srv/webplatform/kuma/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

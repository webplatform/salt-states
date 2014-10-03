include:
  - rsync.secret
  - code.prereq

packages-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.wpdn::code/packages/ /srv/webplatform/packages/"
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

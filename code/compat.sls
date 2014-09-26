include:
  - rsync.secret
  - code.prereq

rsync -a --compress --delete --no-perms --exclude 'package.json' --exclude '.git*' --exclude 'README.md' --exclude 'node_modules' --password-file=/etc/codesync.secret codesync@salt.wpdn::code/compat/repo/ /srv/webplatform/compat/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

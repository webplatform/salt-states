include:
  - rsync.secret
  - code.prereq

rsync-compat:
  cmd.run:
    - name: "rsync -a --compress --delete --no-perms --exclude 'package.json' --exclude '.git*' --exclude 'README.md' --exclude 'node_modules' --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/compat/repo/ /srv/webplatform/compat/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

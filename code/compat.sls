include:
  - code.prereq
  - rsync.secret

# @salt-master-dest
rsync-compat:
  cmd.run:
    - name: "rsync -a --compress --delete --no-perms --exclude 'package.json' --exclude '.git*' --exclude 'README.md' --exclude 'node_modules' --password-file=/etc/codesync.secret codesync@salt::code/compat/repo/ /srv/webplatform/compat/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

include:
  - rsync.secret
  - code.prereq

# @salt-master-dest
rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/gerrit/ /srv/webplatform/gerrit/:
  cmd.wait:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

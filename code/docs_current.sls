# Include the common settings for the docs repo
include:
  - code.docs_settings
  - code.prereq
  - rsync.secret

rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/docs/current/ /srv/webplatform/wiki/current/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

include:
  - rsync.secret
  - code.prereq
  - php.buggenie
  - buggenie.config

buggenie-codesync:
  cmd.run:
    - name: "rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/buggenie/repo/ /srv/webplatform/buggenie/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

/srv/webplatform/buggenie:
  file.directory:
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
    - require_in:
      - file: /srv/webplatform/buggenie/core/cache

/srv/webplatform/buggenie/core/cache:
  file.directory:
    - makedirs: True
    - require:
      - cmd: buggenie-codesync

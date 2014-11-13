include:
  - rsync.secret
  - code.prereq

dabblet-rsync:
  cmd:
    - run
    - name: "rsync -a --exclude '.git' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/dabblet/repo/ /srv/webplatform/dabblet/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: /srv/webplatform/dabblet

/srv/webplatform/dabblet:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data

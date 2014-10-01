include:
  - rsync.secret
  - code.prereq

dabblet-rsync:
  cmd:
    - run
    - name: "rsync -a --exclude '.git' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.wpdn::code/dabblet/repo/ /srv/webplatform/dabblet/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/dabblet

/srv/webplatform/dabblet:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data

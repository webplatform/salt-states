include:
  - rsync.secret
  - code.prereq

specs-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.wpdn::code/specs/out/ /srv/webplatform/specs/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/webspecs/specs

/srv/webplatform/webspecs/specs:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data

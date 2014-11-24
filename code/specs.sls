include:
  - rsync.secret
  - code.prereq

# @salt-master-dest
specs-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/specs/repo/out/ /srv/webplatform/specs/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: /srv/webplatform/specs

/srv/webplatform/specs:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data

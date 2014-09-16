include:
  - rsync.secret
  - code.prereq

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/webspecs/specs/out/ /srv/webplatform/webspecs/specs/:
  cmd.run:
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

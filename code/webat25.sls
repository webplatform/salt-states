include:
  - rsync.secret
  - code.prereq

# @salt-master-dest
rsync-webat25:
  cmd.run:
    - name: rsync -a --no-perms --password-file=/etc/codesync.secret codesync@salt::code/webat25/repo/public/ /srv/webplatform/webat25/
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: /srv/webplatform/webat25
  file.directory:
    - name: /srv/webplatform/webat25
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group


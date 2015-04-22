include:
  - rsync.secret
  - code.prereq
  - users.app-user
  - groups.w3t

# @salt-master-dest
rsync-specs-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@salt::code/packages/specs/dists/ /srv/webplatform/appshomedir/dists/specs/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/appshomedir/dists/specs
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/appshomedir/dists/specs
    - user: app-user
    - group: w3t
    - makedirs: True
    - require:
      - file: /srv/webplatform/appshomedir
      - user: app-user
    - recurse:
      - user
      - group

# @salt-master-dest
rsync-specs:
  cmd.run:
    - name: "rsync -a --no-perms --password-file=/etc/codesync.secret codesync@salt::code/specs/repo/ /srv/webplatform/specs/"
    - user: root
    - group: root
    - unless: test -f /srv/webplatform/specs/index.html
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/specs
    - user: www-data
    - group: w3t
    - makedirs: True
    - file_mode: 644
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode


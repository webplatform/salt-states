include:
  - rsync.secret
  - code.prereq

# @salt-master-dest
rsync-hypothesis:
  cmd.run:
    - name: "rsync -a  --exclude '.git' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/notes-server/repo/ /srv/webplatform/notes-server/"
    - group: deployment
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/notes-server
  file.directory:
    - name: /srv/webplatform/notes-server
    - user: www-data
    - group: www-data
    - file_mode: 644
    - dir_mode: 755
    - require:
      - file: webplatform-sources
    - recurse:
      - user
      - group
      - mode

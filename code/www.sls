include:
  - code.prereq
  - rsync.secret
  - code.certificates

# @salt-master-dest
root-rsync:
  cmd.run:
    - stateful: True
    - name: "rsync -a --delete --no-perms --exclude '**/frontend-styleguide' --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/ /var/www/"
    - require:
      - file: /etc/codesync.secret

# @salt-master-dest
campaign-rsync:
  cmd.run:
    - stateful: True
    - name: "rsync -a --delete --no-perms --exclude '.git' --password-file=/etc/codesync.secret codesync@salt::code/campaign-bookmarklet/repo/ /var/www/campaign/"
    - require:
      - file: /etc/codesync.secret
      - cmd: root-rsync

# @salt-master-dest
docsprint-dashboard-rsync:
  cmd.run:
    - stateful: True
    - name: "rsync -a --delete --no-perms --exclude 'README.md' --exclude '.git' --password-file=/etc/codesync.secret codesync@salt::code/docsprint-dashboard/repo/ /var/www/docsprint-dashboard/"
    - require:
      - file: /etc/codesync.secret
      - cmd: root-rsync

/var/www:
  file.directory:
    - dir_mode: 755
    - file_mode: 444
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
      - mode
    - require:
      - cmd: campaign-rsync
      - cmd: root-rsync
      - cmd: docsprint-dashboard-rsync

/var/www/errors/index.php:
  file.managed:
    - source: salt://code/files/www/errors.php
    - user: www-data
    - group: www-data
    - require:
      - file: /var/www

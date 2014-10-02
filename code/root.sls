include:
  - rsync.secret
  - code.prereq
  - code.certificates

root-rsync:
  cmd:
    - wait
    - name: "rsync -a --delete --no-perms --exclude '**/frontend-styleguide' --password-file=/etc/codesync.secret codesync@salt.wpdn::code/www/out/ /var/www/"
    - require:
      - file: /etc/codesync.secret

campaign-rsync:
  cmd:
    - wait
    - name: "rsync -a --delete --no-perms --exclude '.git' --password-file=/etc/codesync.secret codesync@salt.wpdn::code/campaign-bookmarklet/ /var/www/campaign/"
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

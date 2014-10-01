include:
  - rsync.secret
  - code.prereq
  - code.certificates

root-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --exclude '**/frontend-styleguide' --password-file=/etc/codesync.secret codesync@salt.wpdn::code/www/out/ /var/www/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

include:
  - rsync.secret
  - code.prereq

rsync -a --delete --no-perms --exclude '**/frontend-styleguide' --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/www/out/ /var/www/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

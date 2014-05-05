## deployment of the blog has been disabled
include:
  - rsync.secret
  - code.prereq

/srv/webplatform/blog/current/robots.txt:
  file.managed:
    - source: salt://code/files/blog/robots.txt
    - user: www-data
    - group: www-data

rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/blog/webplatform-wordpress-theme/ /srv/webplatform/blog/current/wp-content/themes/webplatform/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

#rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/blog/ /srv/webplatform/blog/:
#  cmd.run:
#    - user: root
#    - group: root
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform

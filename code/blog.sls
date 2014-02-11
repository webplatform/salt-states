## deployment of the blog has been disabled

/srv/webplatform/blog/current/robots.txt:
  file.managed:
    - source: salt://code/files/blog/robots.txt
    - user: www-data
    - group: www-data

## Include the common settings for the docs repo
#include:
#  - rsync.secret
#  - code.prereq
#
#rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/blog/ /srv/webplatform/blog/:
#  cmd.run:
#    - user: root
#    - group: root
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform

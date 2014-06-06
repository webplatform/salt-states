# Include the common settings for the docs repo
include:
  - rsync.secret
  - code.prereq

#rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/hypothesis/current/ /srv/webplatform/h/:
#  cmd.run:
#    - user: renoirb
#    - group: deployment
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform

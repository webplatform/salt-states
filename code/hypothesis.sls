# Include the common settings for the docs repo
include:
  - rsync.secret
  - code.prereq

#rsync-hypothesis-code:
#  cmd.run:
#    - name: "rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/hypothesis/current/ /srv/webplatform/h/"
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform
#  file.directory:
#    - name: /srv/webplatform/h
#    - user: renoirb
#    - group: deployment
#    - require:
#      - cmd: rsync-hypothesis-code
#    - dir_mode: 0755
#    - file_mode: 0644
#    - recurse:
#      - user
#      - group

#fix-rsync-perms-git:
#  cmd.wait:
#    - name: git reset --hard HEAD
#    - cwd: /srv/webplatform/h
#    - user: renoirb
#    - watch:
#      - cmd: rsync-hypothesis-code

/srv/webplatform/h/h/favicon.ico:
  file.managed:
    - source: salt://hypothesis/files/favicon.ico

/srv/webplatform/h/customizations.patch:
  file.managed:
    - source: salt://hypothesis/files/customizations.patch

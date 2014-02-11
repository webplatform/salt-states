# Include the common settings for the docs repo
include:
  - code.docs_settings
  - code.prereq
  - rsync.secret

ensure-cache-writable-test:
  file.directory:
    - name: /srv/webplatform/wiki/test/cache
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/test:
  file.directory:
    - makedirs: True

## Normal mode - test deploys from same location as current
rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret --exclude="LocalSettings.php" codesync@deployment.dho.wpdn::code/docs/current/ /srv/webplatform/wiki/test/:
  cmd.run:
    - user: root
    - group: root
    - require_in:
      - file: ensure-cache-writable-test
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/wiki/test


## Upgrade mode - test runs from its own directory
#rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret --exclude="LocalSettings.php" codesync@deployment.dho.wpdn::code/docs/test/ /srv/webplatform/wiki/test/:
#  cmd.run:
#    - user: root
#    - group: root
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform

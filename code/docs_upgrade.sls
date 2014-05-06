# Include the common settings for the docs repo
include:
  - code.docs_settings
  - code.prereq
  - rsync.secret

ensure-cache-writable-upgrade:
  file.directory:
    - name: /srv/webplatform/wiki/upgrade/cache
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/upgrade:
  file.directory:
    - makedirs: True

## Normal mode - upgrade deploys from same location as current
rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret --exclude="LocalSettings.php" codesync@deployment.dho.wpdn::code/docs/upgrade/ /srv/webplatform/wiki/upgrade/:
  cmd.run:
    - user: root
    - group: root
    - require_in:
      - file: ensure-cache-writable-upgrade
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/wiki/upgrade

rsync -a --exclude '.git' --exclude '.svn' --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/wpd-mediawiki/skins/ /srv/webplatform/wiki/upgrade/skins/:
  cmd.run:
    - require:
      - file: /srv/webplatform/wiki/upgrade

rsync -a --exclude '.git' --exclude '.svn' --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/wpd-mediawiki/extensions/ /srv/webplatform/wiki/upgrade/extensions/:
  cmd.run:
    - require:
      - file: /srv/webplatform/wiki/upgrade

rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/docs/SettingsRefactor.php /srv/webplatform/wiki/SettingsRefactor.php:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret

include:
  - rsync.secret
  - code.prereq
  - cron

# Related links
# * http://www.causingeffect.com/software/expressionengine/ce-cache/user-guide/installation
# * http://www.causingeffect.com/software/expressionengine/ce-cache/user-guide/static
# * http://www.causingeffect.com/software/expressionengine/ce-image/user-guide/installation
# * http://www.causingeffect.com/software/expressionengine/ce-image/user-guide/configuration#advanced_config
# * https://madebyhippo.uservoice.com/knowledgebase/articles/47424-libraree-installation
# * http://devot-ee.com/add-ons/libraree
# * https://madebyhippo.uservoice.com/knowledgebase/topics/751-documentation
# * http://ellislab.com/expressionengine/user-guide/installation/installation.html
# * http://ellislab.com/expressionengine/user-guide/installation/best_practices.html
# * http://ellislab.com/expressionengine/user-guide/installation/requirements.html
# * http://eeinsider.com/articles/securing-expressionengine-2
# * http://www.php.net/manual/en/configuration.changes.php
# * https://github.com/murtaugh/webat25

#JOBNAME=webat25-archive GITFOLDER='/srv/webplatform/web25ee' cronhelper.sh archive-noncommited.sh:
#  cron.exist:
#    - hour: '*/5'
#    - minute: 1
#    - require:
#      - file: archive-noncommited.sh
#      - file: cronhelper.sh

# rsync -a --no-perms --delete --filter '- .rsync-filter' --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/web25ee/docroot/ /srv/webplatform/web25ee/
# rsync --dry-run -a --no-perms --delete --filter '- /srv/code/web25ee/docroot/.rsync-filter' --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/web25ee/docroot/ /srv/webplatform/web25ee/
sync-web25ee:
  cmd.run:
    - name: rsync -a --no-perms --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/web25ee/docroot/ /srv/webplatform/web25ee/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/web25ee
  file.directory:
    - name: /srv/webplatform/web25ee
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

ee-special-perms:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - require:
      - file: /srv/webplatform/web25ee
      - file: /srv/webplatform/web25ee/backoffice/expressionengine/config/config.php
      - file: /srv/webplatform/web25ee/backoffice/expressionengine/config/database.php
    - recurse:
      - user
      - group
    - names:
      - /srv/webplatform/web25ee/backoffice/expressionengine/cache
      - /srv/webplatform/web25ee/images/made   # Required by CE Image
      - /srv/webplatform/web25ee/images/remote # ^
      - /srv/webplatform/web25ee/assets        # Required by LibrarEE
      - /srv/webplatform/web25ee/images/avatars/uploads
      - /srv/webplatform/web25ee/images/captchas
      - /srv/webplatform/web25ee/images/member_photos
      - /srv/webplatform/web25ee/images/pm_attachments
      - /srv/webplatform/web25ee/images/signature_attachments
      - /srv/webplatform/web25ee/images/uploads

/srv/webplatform/web25ee/backoffice/expressionengine/config/config.php:
  file.managed:
    - source: salt://code/files/web25/config.php.jinja
    - template: jinja
    - mode: 666
    - user: www-data
    - group: www-data

/srv/webplatform/web25ee/backoffice/expressionengine/config/database.php:
  file.managed:
    - source: salt://code/files/web25/database.php.jinja
    - template: jinja
    - mode: 666
    - user: www-data
    - group: www-data

ce-cache-static-handler-cachedir:
  file.replace:
    - name: /srv/webplatform/web25ee/_static_cache_handler.php
    - pattern: ce_cache\/xxxxxx
    - repl: ce_cache/a5dcb0
    - count: 1
    - require:
      - file: ee-special-perms

ce-cache-static-handler-enable:
  file.replace:
    - name: /srv/webplatform/web25ee/_static_cache_handler.php
    - pattern: private $disabled = true
    - repl: private $disabled = false
    - count: 1
    - require:
      - file: ee-special-perms

/srv/webplatform/web25ee/static/ce_cache/a5dcb0:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 775
    - makedirs: True
    - require:
      - file: ce-cache-static-handler-cachedir

webat25-requirements:
  pkg.installed:
    - pkgs:
      - php5-gd
  cmd.run:
    - name: a2enmod expires

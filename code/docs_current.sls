# Include the common settings for the docs repo
include:
  - code.docs_settings
  - code.prereq
  - rsync.secret

ensure-cache-writable-current:
  file.directory:
    - name: /srv/webplatform/wiki/current/cache
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/wiki/current:
  file.directory:
    - makedirs: True

rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/docs/current/ /srv/webplatform/wiki/current/:
  cmd.run:
    - user: root
    - group: root
    - require_in:
      - file: ensure-cache-writable-current
    - requires:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/wiki/current

include:
  - rsync.secret
  - code.prereq
  - php.buggenie

# @salt-master-dest
buggenie-codesync:
  cmd.run:
    - name: "rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/buggenie/repo/ /srv/webplatform/buggenie/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

/srv/webplatform/buggenie/installed:
  file.managed:
    - source: salt://code/files/buggenie/installed

/srv/webplatform/buggenie:
  file.directory:
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
    - require_in:
      - file: /srv/webplatform/buggenie/core/cache

/srv/webplatform/buggenie/core/cache:
  file.directory:
    - makedirs: True
    - require:
      - cmd: buggenie-codesync

/srv/webplatform/buggenie/core:
  file.directory:
    - user: www-data
    - group: www-data

buggenie-dbconfig:
  file.managed:
    - name: /srv/webplatform/buggenie/core/b2db_bootstrap.inc.php
    - source: salt://code/files/buggenie/b2db_bootstrap.inc.php.jinja
    - template: jinja
    - user: nobody
    - group: www-data
    - require:
      - file: /srv/webplatform/buggenie/core
      - cmd: buggenie-codesync

/var/www/robots.txt:
  file.managed:
    - source: salt://buggenie/files/robots.txt
    - user: www-data
    - group: www-data


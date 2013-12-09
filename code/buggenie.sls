include:
  - rsync.secret
  - php.buggenie
  - code.prereq
  - buggenie.install

buggenie-codesync:
  cmd.run:
    - name: 'rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/buggenie/ /srv/webplatform/buggenie/'
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

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

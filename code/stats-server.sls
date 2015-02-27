include:
  - rsync.secret
  - code.prereq
  - code.certificates
  - users.app-user


# @salt-master-dest
sync-piwik-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@salt::code/packages/stats-server/dists/ /srv/webplatform/appshomedir/dists/stats-server/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/appshomedir/dists/stats-server
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/appshomedir/dists/stats-server
    - user: app-user
    - group: www-data
    - makedirs: True
    - require:
      - file: /srv/webplatform/appshomedir
      - user: app-user
    - recurse:
      - user
      - group


clone-piwik:
  pkg.installed:
    - name: git
  git.latest:
    - name: git@source.webplatform.org:piwik.git
    - user: app-user
    - target: /srv/webplatform/stats-server
    - identity: /srv/webplatform/.ssh/id_ed25519
    - rev: 2.10.0-wpd
    - submodules: True
    - unless: test -f /srv/webplatform/stats-server/config/config.ini.php
    - require:
      - file: /srv/webplatform/stats-server
      - pkg: git
      - file: /srv/webplatform/appshomedir/.ssh/id_ed25519
  file.directory:
    - name: /srv/webplatform/stats-server
    - require:
      - file: webplatform-sources
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group


/srv/webplatform/stats-server/config/config.ini.php:
  file.managed:
    - source: salt://code/files/stats-server/config.ini.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - require:
      - git: clone-piwik

/srv/webplatform/stats-server/bootstrap.php:
  file.managed:
    - source: salt://code/files/stats-server/bootstrap.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - require:
      - git: clone-piwik


include:
  - rsync.secret
  - code.prereq
  - code.certificates
  - users.app-user


clone-piwik:
  pkg.installed:
    - name: git
  git.latest:
    - name: git@source.webplatform.org:piwik.git
    - user: app-user
    - target: /srv/webplatform/piwik
    - identity: /srv/webplatform/.ssh/id_ed25519
    - rev: 2.10.0-wpd
    - submodules: True
    - unless: test -f /srv/webplatform/piwik/config/config.ini.php
    - require:
      - file: /srv/webplatform/piwik
      - pkg: git
      - file: /srv/webplatform/appshomedir/.ssh/id_ed25519
  file.directory:
    - name: /srv/webplatform/piwik
    - require:
      - file: webplatform-sources
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group


/srv/webplatform/piwik/tmp:
  file.directory:
    - user: app-user
    - group: www-data
    - mode: 775
    - makedirs: True
    - recurse:
      - user
      - group
      - mode


/srv/webplatform/piwik/config/config.ini.php:
  file.managed:
    - source: salt://code/files/piwik/config.ini.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - require:
      - git: clone-piwik

/srv/webplatform/piwik/bootstrap.php:
  file.managed:
    - source: salt://code/files/piwik/bootstrap.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - require:
      - git: clone-piwik


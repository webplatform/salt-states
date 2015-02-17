app-user:
  user.present:
    - fullname: web application runner user
    - shell: /bin/bash
    - home: /srv/webplatform/appshomedir
    - createhome: False
    - system: True
    - groups:
      - www-data

/srv/webplatform/appshomedir:
  file.directory:
    - user: app-user
    - group: www-data
    - require:
      - user: app-user

/srv/webplatform/appshomedir/.ssh:
  file.directory:
    - createdirs: True
    - user: app-user
    - group: app-user
    - mode: 0700
    - require:
      - file: /srv/webplatform/appshomedir

/srv/webplatform/appshomedir/.ssh/id_ed25519:
  file.managed:
    - contents_pillar: sshkeys:wpdci:id_ed25519:private
    - user: app-user
    - group: app-user
    - mode: 0600
    - require:
      - file: /srv/webplatform/appshomedir/.ssh

/srv/webplatform/appshomedir/.ssh/id_ed25519.pub:
  file.managed:
    - contents_pillar: sshkeys:wpdci:id_ed25519:public
    - user: app-user
    - group: app-user
    - mode: 0600
    - require:
      - file: /srv/webplatform/appshomedir/.ssh


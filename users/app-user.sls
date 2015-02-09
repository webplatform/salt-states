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

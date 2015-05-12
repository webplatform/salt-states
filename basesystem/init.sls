# Will eventually be from salt-basesystem statefile.
# ref: https://github.com/renoirb/salt-basesystem
webapps:
  user.present:
    - fullname: Web Application runner user
    - shell: /bin/bash
    - home: /srv/webapps
    - createhome: True
    - system: True
    - uid: 990
    - groups:
      - www-data
  group.present:
    - gid: 990
    - system: True
    - members:
      - webapps
  file.directory:
    - name: /srv/webapps
    - user: webapps
    - group: webapps


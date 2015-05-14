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

## Those should superseed what the app-user had
/srv/webapps/.ssh:
  file.directory:
    - createdirs: True
    - user: webapps
    - group: webapps
    - mode: 0700
    - require:
      - file: /srv/webapps

/srv/webapps/.ssh/id_ed25519:
  file.managed:
    - contents_pillar: sshkeys:wpdci:id_ed25519:private
    - user: webapps
    - group: webapps
    - mode: 0600
    - require:
      - file: /srv/webapps/.ssh

/srv/webapps/.ssh/id_ed25519.pub:
  file.managed:
    - contents_pillar: sshkeys:wpdci:id_ed25519:public
    - user: webapps
    - group: webapps
    - mode: 0600
    - require:
      - file: /srv/webapps/.ssh

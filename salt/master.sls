salt-deps:
  pkg.installed:
    - pkgs:
      - python-dulwich
      - python-git
      - php5-curl
      - python-novaclient
      - salt-cloud
      - python-libcloud
      - salt-api

## SecurityGroup port: TCP 4505 4506 @salt
salt-master:
  pkg:
    - installed

/usr/local/bin/wpd-deploy.sh:
  file.managed:
    - user: root
    - group: root
    - source: salt://salt/files/wpd-deploy.sh
    - mode: 755

/etc/salt/master.d/roots.conf:
  file.managed:
    - source: salt://salt/files/roots.conf

/etc/salt/master.d/runners.conf:
  file.managed:
    - source: salt://salt/files/runners.conf

/etc/salt/master.d/peers.conf:
  file.managed:
    - source: salt://salt/files/peers.conf.jinja
    - template: jinja

/etc/salt/master.d/gitfs.conf:
  file.managed:
    - source: salt://salt/files/gitfs.conf

/etc/salt/master.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/master-overrides.conf

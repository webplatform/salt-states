#
# Things that are specific to deployment machine
#
/etc/bash.bashrc:
  file:
    - managed
    - source: salt://environment/bash.bashrc
    - user: root
    - group: root
    - mode: 644

#web25-autoupdate:
#  file.managed:
#    - source: salt://code/files/web25/webat25-autoupdate.sh
#    - name: /srv/code/web25ee/web25-autoupdate.sh
#    - mode: 755
#  cron.present:
#    - user: root
#    - hour: '*/2'
#    - name: "JOBNAME=web25-autoupdate cronhelper.sh /srv/code/web25ee/web25-autoupdate.sh"
#    - require:
#      - file: /srv/code/web25ee/web25-autoupdate.sh

/etc/ssh/sshd_config:
  file.append:
    - text: Banner /etc/issue.net

/etc/issue.net:
  file.managed:
    - source: salt://environment/issue.net

/etc/profile.d/nova.sh:
  file.managed:
    - user: root
    - group: deployment
    - mode: 640
    - template: jinja
    - source: salt://environment/nova-profile.sh.jinja

/root/.my.cnf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - source: salt://environment/files/my.cnf.jinja

deployment-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - libterm-readkey-perl
      - percona-toolkit
      - nodejs
      - nodejs-legacy
      - npm
      - bundler
      - python-dulwich
      - python-git
      - php5-curl
      - python-novaclient
      - salt-cloud
      - python-libcloud

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

#cloudarchive-repos:
#  pkgrepo.managed:
#    - humanname: Openstack Havana archive for Ubuntu 12.04 LTS
#    - name: deb http://ubuntu-cloud.archive.canonical.com/ubuntu precise-updates/havana main
#    - keyserver: keyserver.ubuntu.com
#    - keyid: EC4926EA
#    - file: /etc/apt/sources.list.d/cloudarchive-havana.list
#cloud-archive-repo:
#  cmd:
#    - run
#    - name: add-apt-repository cloud-archive:havana
#    - creates: /etc/apt/sources.list.d/cloudarchive-havana.list
#    - unless: test -f /etc/apt/sources.list.d/cloudarchive-havana.list

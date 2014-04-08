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

/etc/profile.d/nova.sh:
  file.managed:
    - user: root
    - group: ops
    - mode: 640
    - source: salt://environment/nova-profile.sh

/root/.my.cnf:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - source: salt://environment/my.cnf

useful-pkgs:
  pkg.installed:
    - pkgs:
      - build-essential
      - libterm-readkey-perl
      - percona-toolkit

python-nova-pkgs:
  pkg.latest:
    - pkgs:
      - python-novaclient
    - refresh: True
    - require:
      - cmd: cloud-archive-repo

/usr/local/bin/deploy.sh:
  file.managed:
    - user: root
    - group: root
    - source: salt://environment/deploy.sh
    - mode: 755

/etc/salt/master.d/roots.conf:
  file.managed:
    - source: salt://specific/files/deployment/roots.conf

/etc/salt/master.d/runners.conf:
  file.managed:
    - source: salt://specific/files/deployment/runners.conf

#cloudarchive-repos:
#  pkgrepo.managed:
#    - humanname: Openstack Havana archive for Ubuntu 12.04 LTS
#    - name: deb http://ubuntu-cloud.archive.canonical.com/ubuntu precise-updates/havana main
#    - keyserver: keyserver.ubuntu.com
#    - keyid: EC4926EA
#    - file: /etc/apt/sources.list.d/cloudarchive-havana.list
cloud-archive-repo:
  cmd:
    - run
    - name: add-apt-repository cloud-archive:havana
    - creates: /etc/apt/sources.list.d/cloudarchive-havana.list
    - unless: test -f /etc/apt/sources.list.d/cloudarchive-havana.list

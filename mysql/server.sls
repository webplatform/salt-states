salt-dependency:
  pkg.installed:
    - name: python-mysqldb
    - requires:
      - pkg: mariadb-server
      - file: /etc/mysql/debian.cnf

/etc/mysql/debian.cnf:
  file.managed:
    - modes: 600
    - source: salt://mysql/files/debian.cnf.jinja
    - template: jinja

#mysql-server:
#  pkg:
#    - installed
#  service:
#    - name: mysql
#    - running
#    - require:
#      - pkg: mysql-server
#      - file: /etc/apparmor.d/usr.sbin.mysqld
#    - watch:
#      - file: /etc/mysql/conf.d
#      - file: /etc/mysql/my.cnf
#
## https://blogs.oracle.com/jsmyth/entry/apparmor_and_mysql
#apparmor:
#  pkg:
#    - installed
#  service.running:
#    - watch:
#      - file: /etc/apparmor.d/usr.sbin.mysqld

#/etc/apparmor.d/usr.sbin.mysqld:
#  file.patch:
##    - hash: md5=3d0d5311d599ab6fc48f74efdf7443e0    # Ubuntu 10.04
#    - hash: md5=c773199742d3eab522de1a5a95fcd2d8    # Ubuntu 10.04.4
#    - source: salt://mysql/apparmor.patch
#    - require:
#      - pkg: apparmor

#/etc/mysql/my.cnf:
#  file.managed:
#    - user: root
#    - group: root
#    - mode: 644
#    - source: salt://mysql/files/my.cnf.jinja
#    - template: jinja
#    - require:
#      - pkg: mysql-server

/etc/mysql/conf.d:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - include_empty: True
    - source: salt://mysql/files/conf.d

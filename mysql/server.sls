include:
  - mysql

mysql-server:
  pkg:
    - installed
  service:
    - name: mysql
    - running
    - require:
      - pkg: mysql-server
      - file: /etc/apparmor.d/usr.sbin.mysqld
    - watch:
      - file: /etc/mysql/my.cnf

apparmor:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/apparmor.d/usr.sbin.mysqld

/etc/apparmor.d/usr.sbin.mysqld:
  file.patch:
    - hash: md5=3d0d5311d599ab6fc48f74efdf7443e0
    - source: salt://mysql/apparmor.patch
    - require:
      - pkg: apparmor

/etc/mysql/my.cnf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://mysql/my.cnf
    - template: jinja
    - require:
      - pkg: mysql-server

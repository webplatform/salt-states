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
    - watch:
      - file: /etc/mysql/my.cnf

/etc/mysql/my.cnf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://mysql/my.cnf
    - template: jinja
    - require:
      - pkg: mysql-server

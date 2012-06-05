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

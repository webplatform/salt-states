include:
  - .
  - mmonit
  - python.mysqldb

db-server:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - galera
      - percona-toolkit
      - percona-xtrabackup
    - require:
      - pkgrepo: mariadb-apt-repo
  service.running:
    - name: mysql
    - reload: True
    - enable: True

comment-mycnf-network-listener:
  file.comment:
    - regex: ^bind-address
    - name: /etc/mysql/my.cnf

/etc/mysql/conf.d/replication.cnf:
  file.managed:
    - source: salt://mysql/files/replication.cnf.jinja
    - template: jinja
    - mode: 644

{%- set configFiles = ['listener','unicode-server', 'pidfile'] -%}
{%- for f in configFiles %}
/etc/mysql/conf.d/{{ f }}.cnf:
  file.managed:
    - source: salt://mysql/files/{{ f }}.cnf
    - mode: 644
{% endfor -%}

/etc/monit/conf.d/mysql.conf:
  file.managed:
    - source: salt://mysql/files/monit.conf.jinja
    - template: jinja
    - watch_in:
      - service: monit

/root/.my.cnf:
  file.symlink:
    - target: /etc/mysql/debian.cnf
include:
  - mysql.ssl
  - mysql
  - mmonit

salt-dependency:
  pkg.installed:
    - name: python-mysqldb
    - require:
      - pkg: db-server
      - file: /etc/mysql/debian.cnf

db-server:
  pkg.installed:
    - pkgs:
      - mariadb-server-10.1
      - galera
      - percona-toolkit
      - percona-xtrabackup
    - require:
      - pkgrepo: mariadb-apt-repo
  service.running:
    - name: mysql
    - reload: True
    - enable: True
    - require:
      - pkg: db-server

/etc/mysql/debian.cnf:
  file.managed:
    - modes: 600
    - source: salt://mysql/files/debian.cnf.jinja
    - template: jinja
    - require:
      - pkg: mysql

comment-mycnf-network-listener:
  file.comment:
    - regex: ^bind-address
    - name: /etc/mysql/my.cnf
    - require:
      - pkg: mysql

{%- set configFiles = ['listener','unicode-server'] -%}
{%- for f in configFiles %}
/etc/mysql/conf.d/{{ f }}.cnf:
  file.managed:
    - source: salt://mysql/files/{{ f }}.cnf
    - mode: 644
    - require:
      - file: comment-mycnf-network-listener
    - watch_in:
      - service: db-server
{% endfor -%}

/etc/monit/conf.d/mysql.conf:
  file.managed:
    - source: salt://mysql/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interfaces: {{ salt['grains.get']('ip4_interfaces:eth0') }}
    - require:
      - service: db-server
    - watch_in:
      - service: monit

include:
  - mysql.ssl
  - mysql
  - mmonit

salt-dependency:
  pkg.installed:
    - name: python-mysqldb
    - require:
      - pkg: db-server

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
    - require:
      - pkg: db-server


comment-mycnf-network-listener:
  file.comment:
    - regex: ^bind-address
    - name: /etc/mysql/my.cnf
    - require:
      - pkg: mysql

/etc/mysql/conf.d/replication.cnf:
  file.managed:
    - source: salt://mysql/files/replication.cnf.jinja
    - template: jinja
    - mode: 644
    - watch_in:
      - service: db-server

{#  evaluate if we add also below 'disable-infile' #TODO #}
{%- set configFiles = ['listener','unicode-server', 'pidfile'] -%}
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

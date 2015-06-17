# Role to expose only one master MySQL server where we send writes.
# We need exactly one, typically called db1-masterdb
# In contrast to ElasticSearch, we need to explicitly set one server to be the master. This is why we have this role.

include:
  - backup.db
  - mysql.databases
  - mysql.grants

/etc/my.cnf:
  file.managed:
    - user: nobody
    - group: deployment
    - mode: 640
    - template: jinja
    - source: salt://mysql/files/my.cnf.jinja

/etc/mysql/debian.cnf:
  file.exists

#
# Only allow Salt commands on the master
# writes operation on non master is dangerous
#
/etc/salt/minion.d/mysql.conf:
  file.managed:
    - mode: 644
    - contents: "mysql.default_file: '/etc/mysql/debian.cnf'"

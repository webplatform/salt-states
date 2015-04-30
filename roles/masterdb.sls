# Role to expose only one master MySQL server where we send writes.
# We need exactly one, typically called db1-masterdb
# In contrast to ElasticSearch, we need to explicitly set one server to be the master. This is why we have this role.

include:
  - backup.db
  - webplatform.swift-dreamobjects
  - mysql.server

#
# Things that are specific to master MySQL node
#
#/mnt:
#  mount.mounted:
#    - device: /dev/vdb1
#    - fstype: xfs
#
/etc/my.cnf:
  file.managed:
    - user: nobody
    - group: deployment
    - mode: 640
    - template: jinja
    - source: salt://specific/db.my.cnf

/etc/mysql/debian.cnf:
  file.exists:
    - require:
      - pkg: mysql

#  file.managed:
#    - modes: 600
#    - source: salt://mysql/files/debian.cnf.jinja
#    - template: jinja
#    - require:
#      - pkg: mysql

#
# Only allow Salt commands on the master
# writes operation on non master is dangerous
#
/etc/salt/minion.d/mysql.conf:
  file.managed:
    - modes: 644
    - source: salt://mysql/minion.mysql.conf
    - require:
      - file: /etc/mysql/debian.cnf


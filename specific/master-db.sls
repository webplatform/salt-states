include:
  - backup.db
  - webplatform.swift-dreamobjects

#
# Things that are specific to master MySQL node
#
/mnt:
  mount.mounted:
    - device: /dev/vdb1
    - fstype: xfs

/etc/my.cnf:
  file.managed:
    - user: nobody
    - group: deployment
    - mode: 640
    - template: jinja
    - source: salt://environment/my.cnf

#
# Only allow Salt commands on the master
# writes operation on non master is dangerous
#
/etc/salt/minion.d/mysql.conf:
  file.managed:
    - modes: 644
    - source: salt://mysql/minion.mysql.conf
    - requires:
      - file: /etc/mysql/debian.cnf

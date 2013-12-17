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

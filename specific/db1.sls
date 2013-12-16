#
# Things that are specific to db1 node
#
/mnt:
  mount.mounted:
    - device: /dev/vdb1
    - fstype: xfs
    - persist: False

# Mount point for the glusterfs filesystems
/srv/storage:
  mount.mounted:
    - device: /dev/vdc
    - fstype: xfs
    - mkmnt: True
    - opts:
      - defaults
  file.directory:
    - user: root
    - group: root

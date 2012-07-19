glusterfs-server:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - requires:
      - pkg: glusterfs-server

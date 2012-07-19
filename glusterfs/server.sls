glusterd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: glusterd
  require:
    - cmd.run: glusterfs-ppa

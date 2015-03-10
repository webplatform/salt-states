include:
  - nfs.client

/mnt/backup/elasticsearch:
  file.directory:
    - user: dhc-user
    - group: dhc-user
    - createdirs: True
  mount.mounted:
    - device: backup:/srv/exports/elasticsearch
    - fstype: nfs4
    # ref: https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-nfs-client-config-options.html
    - opts: _netdev,noatime,soft
    - dump: 0
    - pass_num: 0
    - persist: True
    - mkmnt: True


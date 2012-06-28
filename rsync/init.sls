include:
  - xinetd.rsyncd

/etc/rsyncd.secrets:
  file.managed:
    - source: salt://rsync/rsyncd.secrets
    - user: root
    - group: root
    - mode: 600

/etc/rsyncd.conf:
  file.managed:
    - source: salt://rsync/rsyncd.conf
    - user: root
    - group: root
    - mode: 644

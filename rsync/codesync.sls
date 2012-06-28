/etc/codesync.secret:
  file.managed:
    - source: salt://rsync/codesync.secret
    - user: root
    - group: root
    - mode: 600

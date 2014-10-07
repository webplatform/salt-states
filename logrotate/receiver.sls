/etc/logrotate.d/remote-logs:
  file.managed:
    - source: salt://logrotate/files/remote-logs
    - user: root
    - group: root
    - mode: 644

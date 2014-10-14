include:
  - logrotate

/etc/logrotate.d/remote-logs:
  file.managed:
    - source: salt://logrotate/files/remote-logs
    - mode: 644

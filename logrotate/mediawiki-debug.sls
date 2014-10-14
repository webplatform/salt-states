include:
  - logrotate

/etc/logrotate.d/mediawiki-debug:
  file.managed:
    - source: salt://logrotate/files/mediawiki-debug
    - mode: 644

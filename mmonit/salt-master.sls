include:
  - .

/etc/monit/conf.d/salt-master.conf:
  file.managed:
    - source: salt://salt/files/monit.conf
    - watch_in:
      - service: monit
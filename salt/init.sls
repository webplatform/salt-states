/etc/salt/minion.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/minion-overrides.conf

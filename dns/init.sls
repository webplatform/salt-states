/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://dns/resolv.conf

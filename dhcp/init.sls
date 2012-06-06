/etc/dhcp3/dhclient.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://dhcp/dhclient.conf
    - watch_in:
      - service: networking

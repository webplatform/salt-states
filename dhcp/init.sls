/etc/dhcp/dhclient.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://dhcp/dhclient.conf
    - template: jinja
    - watch_in:
      - service: networking

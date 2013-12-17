{% if grains['lsb_distrib_release'] == "12.04" %}
/etc/dhcp/dhclient.conf:
{% else %}
/etc/dhcp3/dhclient.conf:
{% endif %}
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://dhcp/dhclient.conf
    - template: jinja
    - watch_in:
      - service: networking

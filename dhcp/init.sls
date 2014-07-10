{% if grains['lsb_distrib_release'] == "10.04"  %}
/etc/dhcp3/dhclient.conf:
{% else %}
/etc/dhcp/dhclient.conf:
{% endif %}
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://dhcp/dhclient.conf
    - template: jinja
    - watch_in:
      - service: networking

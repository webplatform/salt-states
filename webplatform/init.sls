/srv/webplatform:
  file:
    - directory
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

commonly-used-utilities:
  pkg.installed:
    - names:
      - htop
      - sysstat
{% if grains['lsb_distrib_release'] == "10.04" %}
      - timeout
{% endif %}

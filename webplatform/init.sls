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

sysstat:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: sysstat
    - watch:
      - file: /etc/default/sysstat

/etc/default/sysstat:
  file.managed:
    - source: salt://webplatform/files/default-sysstat.jinja
    - template: jinja
    - require:
      - pkg: sysstat

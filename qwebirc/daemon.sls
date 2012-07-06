include:
  - apache.proxy

/etc/init.d/qwebirc:
  file.managed:
    - source: salt://qwebirc/qwebirc.init
    - user: root
    - group: root
    - mode: 755

qwebirc:
  service.running:
    - enable: True

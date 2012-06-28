include:
  - xinetd

/etc/xinetd.d/rsync:
  file.managed:
    - source: salt://xinetd/rsync
    - user: root
    - group: root
    - mode: 644

extend:
  xinetd:
    service:
      - watch:
        - file: /etc/xinetd.d/rsync

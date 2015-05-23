include:
  - webplatform

udplog:
  pkg.installed:
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list

/mnt/logs/mw-logs:
  file.directory:
    - user: udp2log
    - mode: 755
    - makedirs: True

/usr/local/bin/demux.py:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://logging/files/demux.py

/etc/udp2log:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://logging/files/udp2log
    - require:
      - pkg: udplog

udp2log:
  service.running:
    - watch:
      - file: /etc/udp2log
    - require:
      - file: /etc/udp2log
      - file: /usr/local/bin/demux.py
      - file: /mnt/logs/mw-logs


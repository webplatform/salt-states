include:
  - python.mysqldb

/srv/webplatform/lumberjack:
  file.recurse:
    - source: salt://bots/lumberjack
    - clean: True
    - user: root
    - group: root
    - include_empty: True

/etc/init.d/lumberjack:
  file.managed:
    - source: salt://bots/lumberjack.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /srv/webplatform/lumberjack

lumberjack:
  service.running:
    - require:
      - file: /etc/init.d/lumberjack
      - pkg: python-mysqldb
#    - watch:
#      - file: /srv/webplatform/lumberjack/irc_config.txt
#      - file: /srv/webplatform/lumberjack/mysql_config.txt

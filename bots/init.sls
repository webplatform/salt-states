include:
  - python.mysqldb

/srv/webplatform/lumberjack:
  file.recurse:
    - source: salt://bots/files/lumberjack
    - clean: True
    - user: root
    - group: root
    - include_empty: True

/etc/init.d/lumberjack:
  file.managed:
    - source: salt://bots/files/lumberjack.init
    - user: root
    - group: root
    - mode: 755
    - requires:
      - file: /srv/webplatform/lumberjack

/srv/webplatform/lumberjack/mysql_config.txt:
  file.managed:
    - source: salt://bots/files/mysql_config.txt.jinja
    - template: jinja 
    - requires:
      - file: /srv/webplatform/lumberjack
      
lumberjack:
  service.running:
    - requires:
      - file: /etc/init.d/lumberjack
      - pkg: python-mysqldb
      - file: /srv/webplatform/lumberjack
      - file: /srv/webplatform/lumberjack/mysql_config.txt
#    - watch:
#      - file: /srv/webplatform/lumberjack/irc_config.txt
#      - file: /srv/webplatform/lumberjack/mysql_config.txt

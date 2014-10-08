include:
  - python.mysqldb
  - mysql

/srv/webplatform/lumberjack:
  file.recurse:
    - source: salt://bots/files/lumberjack
    - clean: True
    - user: root
    - group: root
    - include_empty: True

/etc/init/lumberjack.conf:
  file.managed:
    - source: salt://bots/files/lumberjack.init
    - user: root
    - group: root
    - mode: 755
    - requires:
      - file: /srv/webplatform/mysql_config.txt

/srv/webplatform/lumberjack/mysql_config.txt:
  file.managed:
    - source: salt://bots/files/mysql_config.txt.jinja
    - template: jinja 
    - requires:
      - file: /srv/webplatform/lumberjack
      
lumberjack:
  service.running:
    - requires:
      - pkg: python-mysqldb
      - file: /etc/init/lumberjack.conf
      - file: /srv/webplatform/lumberjack
      - file: /srv/webplatform/lumberjack/mysql_config.txt

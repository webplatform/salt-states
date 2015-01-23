include:
  - python.mysqldb
  - mysql


/etc/init/lumberjack.conf:
  file.managed:
    - source: salt://bots/files/lumberjack.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /srv/webplatform/lumberjack-listener/mysql_config.txt
      - file: /srv/webplatform/lumberjack-listener/irc_config.txt

/srv/webplatform/lumberjack-listener/mysql_config.txt:
  file.exists

/srv/webplatform/lumberjack-listener/irc_config.txt:
  file.exists

lumberjack:
  service.running:
    - require:
      - pkg: python-mysqldb
      - file: /etc/init/lumberjack.conf


include:
  - python.mysqldb
  - mysql

/srv/webplatform/lumberjack-listener:
  file.directory

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
  file.managed:
    - source: salt://bots/files/lumberjack_mysql_config.txt.jinja
    - template: jinja
    - require:
      - file: /srv/webplatform/lumberjack-listener

/srv/webplatform/lumberjack-listener/irc_config.txt:
  file.managed:
    - source: salt://bots/files/lumberjack_irc_config.txt.jinja
    - template: jinja
    - require:
      - file: /srv/webplatform/lumberjack-listener

lumberjack:
  service.running:
    - require:
      - pkg: python-mysqldb
      - file: /etc/init/lumberjack.conf

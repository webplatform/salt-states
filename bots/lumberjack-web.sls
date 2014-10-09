include:
  - mysql

/srv/webplatform/lumberjack-web:
  file.directory

/srv/webplatform/lumberjack-web/config.php:
  file:
    - managed
    - source: salt://bots/files/lumberjack_config.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/webplatform/lumberjack-web

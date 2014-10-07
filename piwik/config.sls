/srv/webplatform/piwik/config:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

/srv/webplatform/piwik/config/config.ini.php:
  file.managed:
    - user: www-data
    - group: www-data
    - mode: 644
    - template: jinja
    - source: salt://piwik/files/config.ini.php.jinja

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
    - source: salt://piwik/config.ini.php

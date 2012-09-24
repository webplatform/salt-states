/srv/webplatform/piwik/tmp:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
/srv/webplatform/piwik/config:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

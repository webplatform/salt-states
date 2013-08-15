include:
  - php.apache
  - php

php-piwik:
  pkg:
    - latest
    - names:
      - php5-mysql

/srv/webplatform/piwik/tmp:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

/srv/webplatform/piwik/config:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

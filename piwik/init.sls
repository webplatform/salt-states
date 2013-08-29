include:
  - php.apache
  - php
  - piwik.config
  - piwik.archive

php-piwik:
  pkg:
    - latest
    - names:
      - php5-mysql

php-requirements:
  pkg:
    - installed
    - names:
      - php5-gd
      - php-image-text
      - php5-curl

/srv/webplatform/piwik/tmp:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

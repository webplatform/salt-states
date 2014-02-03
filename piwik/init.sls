include:
  - php
  - nginx
  - php.fpm
  - piwik.config

php-piwik:
  pkg:
    - installed
    - names:
      - php5-gd
      - php-image-text
      - php5-curl
      - php5-mysql
      - php5-mysqlnd

/etc/nginx/sites-enabled/default:
  file.absent

/srv/webplatform/piwik/tmp:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group

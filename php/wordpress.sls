include:
  - php
  - mysql

php-wordpress:
  pkg.installed:
    - names:
      - php5-curl
      - php5-mysqlnd
      - php5-xmlrpc
      - php5-intl
      - php-openid
      - php-db

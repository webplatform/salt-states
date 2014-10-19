include:
  - php

php-mediawiki:
  pkg:
    - installed
    - names:
      - php5-curl
      - php5-mysqlnd
      - php5-xmlrpc
      - php-openid
      - php-wikidiff2


/etc/php5/apache2/conf.d/mail.ini:
  file:
    - managed
    - source: salt://php/files/mail.ini

include:
  - php

php-mediawiki:
  pkg:
    - installed
    - names:
      - php5-curl
      - php5-mysql
      - php5-xmlrpc
      - php-openid
      - php-luasandbox
      - php-wikidiff2


/etc/php5/conf.d/mail.ini:
  file:
    - managed
    - source: salt://php/files/mail.ini

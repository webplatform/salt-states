include:
  - php

php-apache:
  pkg:
    - latest
    - names:
      - libapache2-mod-php5

/etc/php5/apache2/php.ini:
  file.managed:
    - source: salt://php/php.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: libapache2-mod-php5

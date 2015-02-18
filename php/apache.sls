include:
  - php

libapache2-mod-php5:
  pkg.installed

/etc/php5/apache2/conf.d/30-overrides.ini:
  file.managed:
    - source: salt://php/files/overrides.ini.jinja
    - template: jinja


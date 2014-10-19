include:
  - code.buggenie

/srv/webplatform/buggenie/core:
  file.directory:
    - user: www-data
    - group: www-data

buggenie-dbconfig:
  file.managed:
    - name: /srv/webplatform/buggenie/core/b2db_bootstrap.inc.php
    - source: salt://buggenie/files/b2db_bootstrap.inc.php.jinja
    - template: jinja
    - user: nobody
    - group: www-data
    - require:
      - file: /srv/webplatform/buggenie/core
      - cmd: buggenie-codesync

/var/www/robots.txt:
  file.managed:
    - source: salt://buggenie/files/robots.txt
    - user: www-data
    - group: www-data

include:
  - hosts
  - code.buggenie

buggenie-dbconfig:
  file.managed:
    - name: /srv/webplatform/buggenie/core/b2db_bootstrap.inc.php
    - source: salt://buggenie/files/b2db_bootstrap.inc.php.jinja
    - user: nobody
    - group: www-data
    - require:
      - cmd: buggenie-codesync

/var/www/robots.txt:
  file.managed:
    - source: salt://buggenie/files/robots.txt
    - user: www-data
    - group: www-data

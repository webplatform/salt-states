/etc/apache2/sites-available/disabled:
  file:
    - managed
    - source: salt://apache/disabled
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/var/www/disabled.php
  file:
    - managed
    - source: salt://apache/disabled.php
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/disabled:
  file.symlink:
    - target: /etc/apache2/sites-available/disabled
    - requires:
      - file: /etc/apache2/sites-enabled/disabled
    - watch_in:
      - service: apache2


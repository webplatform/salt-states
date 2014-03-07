include:
  - apache

/etc/apache2/sites-available/webat25:
  file:
    - managed
    - source: salt://apache/webat25
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/webat25:
  file.symlink:
    - target: /etc/apache2/sites-available/webat25
    - requires:
      - file: /etc/apache2/sites-enabled/webat25
    - watch_in:
      - service: apache2

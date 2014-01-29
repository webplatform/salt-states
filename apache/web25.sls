include:
  - apache

/etc/apache2/sites-available/web25:
  file:
    - managed
    - source: salt://apache/web25
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/web25:
  file.symlink:
    - target: /etc/apache2/sites-available/web25
    - requires:
      - file: /etc/apache2/sites-enabled/web25
    - watch_in:
      - service: apache2

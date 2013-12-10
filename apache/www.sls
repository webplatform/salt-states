include:
  - apache

/etc/apache2/sites-available/www:
  file:
    - managed
    - source: salt://apache/www
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/www:
  file.symlink:
    - target: /etc/apache2/sites-available/www
    - requires:
      - file: /etc/apache2/sites-enabled/www
    - watch_in:
      - service: apache2

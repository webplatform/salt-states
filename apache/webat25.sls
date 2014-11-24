include:
  - apache

/etc/apache2/sites-available/webat25.conf:
  file.managed:
    - source: salt://apache/webat25
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/webat25.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/webat25.conf
    - require:
      - file: /etc/apache2/sites-enabled/webat25.conf
    - watch_in:
      - service: apache2

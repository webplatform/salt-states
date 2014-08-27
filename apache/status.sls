include:
  - apache

/etc/apache2/sites-available/status:
  file:
    - managed
    - source: salt://apache/status
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/10-status.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/status
    - requires:
      - file: /etc/apache2/sites-available/status
    - watch_in:
      - service: apache2

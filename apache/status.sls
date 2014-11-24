include:
  - apache

/etc/apache2/sites-available/status.conf:
  file.managed:
    - source: salt://apache/status
    - user: root
    - group: root
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/10-status.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/status.conf
    - require:
      - file: /etc/apache2/sites-available/status.conf
    - watch_in:
      - service: apache2

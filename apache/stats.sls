/etc/apache2/sites-available/stats:
  file:
    - managed
    - source: salt://apache/stats
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/stats:
  file.symlink:
    - target: /etc/apache2/sites-available/stats
    - requires:
      - file: /etc/apache2/sites-enabled/stats
    - watch_in:
      - service: apache2

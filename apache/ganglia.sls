/etc/apache2/sites-available/ganglia:
  file:
    - managed
    - source: salt://apache/ganglia
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/ganglia:
  file.symlink:
    - target: /etc/apache2/sites-available/ganglia
    - requires:
      - file: /etc/apache2/sites-enabled/ganglia
    - watch_in:
      - service: apache2

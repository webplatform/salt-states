/etc/apache2/sites-available/dabblet:
  file:
    - managed
    - source: salt://apache/dabblet
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/dabblet:
  file.symlink:
    - target: /etc/apache2/sites-available/dabblet
    - requires:
      - file: /etc/apache2/sites-enabled/dabblet
    - watch_in:
      - service: apache2

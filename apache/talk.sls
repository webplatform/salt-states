/etc/apache2/sites-available/talk:
  file:
    - managed
    - source: salt://apache/talk
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/talk:
  file.symlink:
    - target: /etc/apache2/sites-available/talk
    - requires:
      - file: /etc/apache2/sites-enabled/talk
    - watch_in:
      - service: apache2

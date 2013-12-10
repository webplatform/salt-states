include:
  - apache
  - apache.headers

/etc/apache2/sites-available/docs:
  file:
    - managed
    - source: salt://apache/docs
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/docs:
  file.symlink:
    - target: /etc/apache2/sites-available/docs
    - requires:
      - file: /etc/apache2/sites-enabled/docs
    - watch_in:
      - service: apache2

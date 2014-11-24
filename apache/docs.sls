include:
  - apache
  - apache.headers

/etc/apache2/sites-available/docs.conf:
  file:
    - managed
    - source: salt://apache/docs
    - user: root
    - group: root
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/01-docs.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/docs.conf
    - require:
      - file: /etc/apache2/sites-available/docs.conf
    - watch_in:
      - service: apache2

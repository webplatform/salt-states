include:
  - apache

/etc/apache2/sites-available/specs.conf:
  file.managed:
    - source: salt://apache/specs
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/03-specs.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/specs.conf
    - requires:
      - file: /etc/apache2/sites-enabled/03-specs.conf
    - watch_in:
      - service: apache2

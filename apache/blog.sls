/etc/apache2/sites-available/blog:
  file:
    - managed
    - source: salt://apache/blog
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/blog:
  file.symlink:
    - target: /etc/apache2/sites-available/blog
    - requires:
      - file: /etc/apache2/sites-enabled/blog
    - watch_in:
      - service: apache2

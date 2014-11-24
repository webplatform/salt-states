include:
  - apache

/etc/apache2/sites-available/blog.conf:
  file:
    - managed
    - source: salt://apache/blog
    - user: root
    - group: root
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/02-blog.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/blog.conf
    - require:
      - file: /etc/apache2/sites-available/blog.conf
    - watch_in:
      - service: apache2

include:
  - apache
  - apache.headers

/etc/apache2/sites-available/webplatform_com.conf:
  file.managed:
    - source: salt://apache/webplatform_com
    - user: root
    - group: root
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/05-webplatform_com.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/webplatform_com.conf
    - require:
      - file: /etc/apache2/sites-available/webplatform_com.conf
    - watch_in:
      - service: apache2

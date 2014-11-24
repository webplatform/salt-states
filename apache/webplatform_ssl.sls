include:
  - apache

/etc/apache2/sites-available/webplatform_ssl.conf:
  file.managed:
    - source: salt://apache/webplatform_ssl
    - user: root
    - group: root
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/00-webplatform_ssl.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/webplatform_ssl.conf
    - require:
      - file: /etc/apache2/sites-available/webplatform_ssl.conf
    - watch_in:
      - service: apache2

/etc/apache2/mods-enabled/ssl.load:
  file:
    - exists

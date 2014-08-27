include:
  - apache
  - apache.proxy

/etc/apache2/sites-available/talk:
  file:
    - managed
    - source: salt://apache/talk
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
      - file: /etc/apache2/mods-available/proxy.conf
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/02-talk.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/talk
    - requires:
      - file: /etc/apache2/sites-available/talk
    - watch_in:
      - service: apache2

/srv/webplatform/bots:
  file.directory:
    - user: root
    - group: root
    - mode: 755

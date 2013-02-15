{% from "apache/module.sls" import a2mod %}
{{ a2mod('rewrite') }}

extend:
  apache2:
    service:
      - watch:
        - cmd: a2enmod rewrite

/etc/apache2/sites-available/buggenie:
  file:
    - managed
    - source: salt://apache/buggenie
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/buggenie:
  file.symlink:
    - target: /etc/apache2/sites-available/buggenie
    - requires:
      - file: /etc/apache2/sites-enabled/buggenie
    - watch_in:
      - service: apache2

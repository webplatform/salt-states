include:
  - apache
  - php

{% from "apache/module.sls" import a2mod %}
{{ a2mod('rewrite') }}

extend:
  apache2:
    service:
      - watch:
        - cmd: a2enmod rewrite

buggenie-requirements:
  pkg:
    - installed
    - names:
      - php5-sqlite

/etc/apache2/sites-available/project:
  file:
    - managed
    - source: salt://apache/project
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/03-project.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/project
    - requires:
      - file: /etc/apache2/sites-available/project
    - watch_in:
      - service: apache2

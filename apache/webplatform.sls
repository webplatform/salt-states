include:
  - apache

{% from "apache/module.sls" import a2mod %}
{{ a2mod('expires') }}
{{ a2mod('headers') }}

/etc/apache2/sites-available/webplatform:
  file:
    - managed
    - source: salt://apache/webplatform
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/webplatform:
  file.symlink:
    - target: /etc/apache2/sites-available/webplatform
    - requires:
      - file: /etc/apache2/sites-enabled/webplatform
    - watch_in:
      - service: apache2

include:
  - apache

{% from "apache/module.sls" import a2mod %}
{{ a2mod('proxy_http') }}

/etc/apache2/sites-available/gerrit:
  file:
    - managed
    - source: salt://apache/gerrit
    - template: jinja
    - user: root
    - group: root
    - mode: 444 
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/gerrit:
  file.symlink:
    - target: /etc/apache2/sites-available/gerrit
    - requires:
      - file: /etc/apache2/sites-enabled/gerrit
    - watch_in:
      - service: apache2

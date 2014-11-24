include:
  - apache
  - apache.headers

{% from "apache/module.sls" import a2mod %}
{{ a2mod('expires') }}

/etc/apache2/sites-available/webplatform.conf:
  file.managed:
    - source: salt://apache/webplatform
    - user: root
    - group: root
    - mode: 444
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/00-webplatform.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/webplatform.conf
    - require:
      - file: /etc/apache2/sites-available/webplatform.conf
    - watch_in:
      - service: apache2

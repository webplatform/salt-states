include:
  - apache
  - apache.headers

{% from "apache/module.sls" import a2mod %}
{{ a2mod('expires') }}

/etc/apache2/sites-available/webplatform-com:
  file:
    - managed
    - source: salt://apache/webplatform-com
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/05-webplatform-com.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/webplatform-com
    - requires:
      - file: /etc/apache2/sites-available/webplatform-com
    - watch_in:
      - service: apache2

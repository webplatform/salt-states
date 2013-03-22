libapache2-mod-wsgi:
  pkg:
    - installed

{% from "apache/module.sls" import a2mod %}
{{ a2mod('rewrite') }}
{{ a2mod('wsgi') }}

extend:
  apache2:
    service:
      - watch:
        - cmd: a2enmod rewrite

/etc/apache2/sites-available/kuma:
  file:
    - managed
    - source: salt://apache/kuma
    - user: root
    - group: root
    - mode: 444
    - requires:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/kuma:
  file.symlink:
    - target: /etc/apache2/sites-available/kuma
    - requires:
      - file: /etc/apache2/sites-enabled/kuma
    - watch_in:
      - service: apache2

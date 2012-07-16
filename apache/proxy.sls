{% from "apache/module.sls" import a2mod %}
{{ a2mod('proxy') }}
{{ a2mod('proxy_http') }}

/etc/apache2/mods-available/proxy.conf:
  file.managed:
    - source: salt://apache/proxy.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: a2enmod proxy

extend:
  apache2:
    service:
      - watch:
        - file: /etc/apache2/mods-available/proxy.conf

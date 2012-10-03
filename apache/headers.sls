{% from "apache/module.sls" import a2mod %}
{{ a2mod('headers') }}

extend:
  apache2:
    service:
      - watch:
        - cmd: a2enmod headers

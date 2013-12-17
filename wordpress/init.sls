include:
  - apache
  - php.wordpress-apache
  - php.wordpress
  - mysql

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}
{{ a2mod('mime') }}
{{ a2mod('headers') }}

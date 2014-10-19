include:
  - apache
  - mysql
  - php.apache
  - apache.webat25
  - php.wordpress-apache

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}
{{ a2mod('mime') }}
{{ a2mod('headers') }}

php-ee:
  pkg.installed:
    - names:
      - php5-mysqlnd
      - php5-intl
      - php5

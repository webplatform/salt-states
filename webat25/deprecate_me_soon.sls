
#
# Install WebAt25.org ExpressionEngine CMS
#
# Soon to be removed
# see: https://github.com/webplatform/ops/issues/170

include:
  - apache
  - mysql
  - php.apache
  - php.wordpress-apache

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}
{{ a2mod('mime') }}
{{ a2mod('headers') }}

php-ee:
  pkg.installed:
    - names:
      - php5-mysql
      - php5-intl
      - php5

/etc/apache2/sites-available/webat25.conf:
  file.managed:
    - source: salt://webat25/files/apache.conf.jinja
    - mode: 444

/etc/apache2/sites-enabled/webat25.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/webat25.conf


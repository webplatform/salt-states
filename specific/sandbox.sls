include:
  - apache
  - php.mediawiki-apache
  - glusterfs
  - php
  - apache.docs
  - mysql.ssl

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}


extend:
  /etc/apache2/sites-available/docs:
    file:
      - source: salt://specific/files/sandbox/docs

# What is in mysql/server.sls, trimmed
salt-dependency:
  pkg.installed:
    - names:
      - python-mysqldb
      - php5-curl

# Only allow Salt commands on the master
# writes operation on non master is dangerous
/etc/salt/minion.d/mysql.conf:
  file.managed:
    - modes: 644
    - source: salt://mysql/minion.mysql.conf

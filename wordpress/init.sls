# test
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

/usr/bin/wpdn-blogcron.sh:
  file:
    - managed
    - source: salt://wordpress/files/wpdn-blogcron.sh
    - user: www-data
    - group: www-data
    - mode: 755
  cron:
    - present
    - name: 'JOBNAME=wp-cron cronhelper.sh /usr/bin/wpdn-blogcron.sh'
    - user: www-data
    - minute: '*/5'
    - hour: '*'

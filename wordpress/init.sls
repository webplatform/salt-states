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

/usr/bin/wpd-blogcron.sh:
  file.managed:
    - source: salt://wordpress/files/wpd-blogcron.sh
    - user: www-data
    - group: www-data
    - mode: 755
  cron.present:
    - identifier: wp-cron
    - name: 'JOBNAME=wp-cron cronhelper.sh /usr/bin/wpd-blogcron.sh'
    - user: www-data
    - minute: '*/5'
    - hour: '*'

## This is required by W3 Total Cache
w3t-requirements:
  pkg.installed:
    - names:
      - php5-memcache

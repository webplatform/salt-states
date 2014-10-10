apache2:
  service:
    - running
    - enable: True
    - reload: true
    - require:
      - pkg: apache2
    - watch:
      - pkg: apache2
  pkg:
    - installed
    - name: apache2-mpm-prefork

/etc/apache2/sites-enabled/000-default.conf:
  file.absent:
    - watch_in:
      - service: apache2

apache_watchdog:
  cron.present:
    - identifier: apache-watchdog
    - user: root
    - minute: '*/2'
    - name: /usr/local/sbin/wpd-apache-watchdog
    - require:
      - file: /usr/local/sbin/wpd-apache-watchdog

/usr/local/sbin/wpd-apache-watchdog:
  file.managed:
    - user: root
    - group: deployment
    - mode: 755
    - source: salt://apache/files/wpd-apache-watchdog

/etc/apache2/conf-enabled/performance.conf:
  file.managed:
    - source: salt://apache/performance.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2

/etc/apache2/conf-enabled/security.conf:
  file.managed:
    - source: salt://apache/security.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2

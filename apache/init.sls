apache2:
  service:
    - running
    - enable: True
    - reload: true
    - require:
      - pkg: apache2
    - watch:
      - pkg: apache2
  pkg.installed:
    - pkgs:
      - apache2
      - apache2-mpm-prefork

# 00: TLD
# 01: docs
# 02: blog
# 03: specs

/etc/apache2/sites-enabled/000-default.conf:
  file.absent:
    - watch_in:
      - service: apache2

/usr/local/sbin/wpd-apache-watchdog:
  file.managed:
    - user: root
    - group: deployment
    - mode: 755
    - source: salt://apache/files/wpd-apache-watchdog
  cron.present:
    - identifier: apache-watchdog
    - user: root
    - minute: '*/2'
    - name: /usr/local/sbin/wpd-apache-watchdog
    - require:
      - file: /usr/local/sbin/wpd-apache-watchdog

/etc/apache2/conf-enabled/performance.conf:
  file.managed:
    - source: salt://apache/files/performance.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2

/etc/apache2/conf-enabled/security.conf:
  file.managed:
    - source: salt://apache/files/security.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2

include:
  - mmonit

apache2:
  pkg.installed:
    - pkgs:
      - apache2
      - apache2-mpm-prefork
  service.running:
    - enable: True
    - reload: true

# 00: TLD
# 01: docs
# 02: blog
# 03: specs

{% for f in ['mods-enabled/deflate.conf'
            ,'mods-enabled/deflate.load'
            ,'sites-enabled/000-default.conf'] %}
/etc/apache2/{{ f }}:
  file.absent:
    - watch_in:
      - service: apache2
{% endfor %}

/usr/local/sbin/wpd-apache-watchdog:
  file.managed:
    - user: root
    - group: deployment
    - mode: 755
    - template: jinja
    - source: salt://apache/files/wpd-apache-watchdog.jinja
  cron.present:
    - identifier: apache-watchdog
    - user: root
    - minute: '*/2'
    - name: /usr/local/sbin/wpd-apache-watchdog
    - require:
      - file: /usr/local/sbin/wpd-apache-watchdog

{% for f in ['performance',
             'security'] %}
/etc/apache2/conf-enabled/{{ f }}.conf:
  file.managed:
    - source: salt://apache/files/{{ f }}.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2
{% endfor %}

/etc/monit/conf.d/apache2.conf:
  file.managed:
    - source: salt://apache/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interfaces: {{ salt['grains.get']('ip4_interfaces:eth0') }}
    - require:
      - service: apache2
    - watch_in:
      - service: monit


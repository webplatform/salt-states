include:
  - mmonit

php5-fpm:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: php5-fpm

/etc/php5/fpm/pool.d/www.conf:
  file.append:
    - text: |
        ; Managed by Salt Stack from state php-fpm/init.sls
        pm.max_children = 30
        pm.start_servers = 10
        pm.min_spare_servers = 5
        pm.max_spare_servers = 20
        pm.max_requests = 500
        env[HOSTNAME] = $HOSTNAME
        env[PATH] = /usr/local/bin:/usr/bin:/bin
        env[TMP] = /tmp
        env[TMPDIR] = /tmp
        env[TEMP] = /tmp
    - require:
      - pkg: php5-fpm
    - watch_in:
      - service: php5-fpm

/etc/monit/conf.d/php5-fpm.conf:
  file.managed:
    - source: salt://php-fpm/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interfaces: {{ salt['grains.get']('ip4_interfaces:eth0') }}
        fpm_port: 9000
    - require:
      - service: php5-fpm
    - watch_in:
      - service: monit


{#
 # PHP FPM base configuration
 #
 # Notes:
 #   - To know the non-swapped memory usage php5-fpm consumes, run:
 #     (Note that the RSS column gives values in KiB)
 #
 #       ps -ylC php5-fpm --sort:rss
 #
 #     Total available RAM / ~ 80Mb per fpm process  = pm.max_children
 #
 # Ref:
 #   - https://github.com/perusio/php-fpm-example-config
 #   - https://rtcamp.com/tutorials/php/fpm-status-page/
 #   - https://rtcamp.com/tutorials/php/fpm-sysctl-tweaking/
 #   - http://myshell.co.uk/index.php/adjusting-child-processes-for-php-fpm-nginx/
 #}
include:
  - mmonit
  - nginx.status
  - php.composer

php5-fpm:
  pkg.installed:
    - pkgs:
      - php5-fpm
      - libfcgi0ldbl
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: php5-fpm


/etc/php5/fpm/conf.d/30-overrides.ini:
  file.managed:
    - source: salt://php/files/overrides.ini.jinja
    - template: jinja

/etc/php5/fpm/php.ini:
  file.replace:
    - pattern: '^memory_limit = 128M$'
    - repl: 'memory_limit = 512M'

/etc/php5/fpm/pool.d/www.conf:
  file.managed:
    - contents: |
        ; Managed by Salt Stack from state php-fpm/init.sls
        ; ref: http://php.net/manual/en/install.fpm.configuration.php

        ; Log config MUST be outside of the blocks
        log_level = debug
        error_log = syslog
        syslog.facility = local1
        ; Would be great if some variant of syntax below would work
        ;php_admin_value[memory_limit] = 512M
        ;catch_workers_output = yes

        [www]
        listen = 127.0.0.1:9000
        user = webapps
        group = www-data
        chdir = /
        pm = dynamic
        pm.max_children = 15
        pm.start_servers = 5
        pm.min_spare_servers = 5
        pm.max_spare_servers = 10
        pm.max_requests = 700
        pm.status_path = /php-status
        ping.path = /php-ping
    - require:
      - user: webapps
    - watch_in:
      - service: php5-fpm

/etc/monit/conf.d/php5-fpm.conf:
  file.managed:
    - source: salt://php-fpm/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interface: 127.0.0.1
        fpm_port: 9000
    - require:
      - pkg: php5-fpm
      - file: /etc/nginx/status.d
    - watch_in:
      - service: monit

/etc/nginx/status.d/fpm.conf:
  file.managed:
    - source: salt://php-fpm/files/fpm-status.conf.jinja
    - template: jinja
    - require:
      - pkg: php5-fpm
      - file: /etc/nginx/status.d
    - watch_in:
      - service: nginx


include:
  - php-fpm
  - nginx

/etc/nginx/status.d/fpm.conf:
  file.managed:
    - source: salt://php-fpm/files/fpm-status.conf.jinja
    - template: jinja
    - require:
      - pkg: php5-fpm
      - file: /etc/nginx/status.d
    - watch_in:
      - service: nginx


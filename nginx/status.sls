include:
  - nginx

/etc/nginx/conf.d/status.conf:
  file.managed:
    - source: salt://nginx/files/status.conf.jinja
    - template: jinja
    - require:
      - pkg: nginx
      - file: /etc/nginx/status.d
    - watch_in:
      - service: monit

/etc/nginx/status.d:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True


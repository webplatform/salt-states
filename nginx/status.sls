/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/files/default.jinja
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


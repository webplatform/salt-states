/opt/nginx/sites-available:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True
    - require:
      - pkg: nginx

/opt/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/files/default.jinja
    - template: jinja
    - user: www-data
    - group: www-data

/opt/nginx/status.d:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True

include:
  - nginx

/etc/nginx/sites-enabled/notes:
  file.managed:
    - source: salt://hypothesis/files/vhost.nginx.conf.jinja
    - template: jinja

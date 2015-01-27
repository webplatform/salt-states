include:
  - nginx

/etc/nginx/sites-enabled/project:
  file.managed:
    - source: salt://buggenie/files/vhost.nginx.conf.jinja
    - template: jinja
    - require:
      - service: nginx
    - context:
        subDomainName: project

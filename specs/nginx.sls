include:
  - specs
  - nginx

/etc/nginx/sites-enabled/01-specs:
  file.managed:
    - source: salt://specs/files/vhost.nginx.conf.jinja
    - template: jinja
    - require:
      - service: nginx
    - context:
        subDomainName: specs


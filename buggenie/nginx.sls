/etc/nginx/sites-enabled/project:
  file.managed:
    - source: salt://buggenie/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        subDomainName: project

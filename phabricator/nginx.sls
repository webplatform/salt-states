
/etc/nginx/sites-enabled/source:
  file.managed:
    - source: salt://phabricator/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        subDomainName: project

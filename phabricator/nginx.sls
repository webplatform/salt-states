
/etc/nginx/sites-enabled/project:
  file.managed:
    - source: salt://phabricator/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        subDomainName: project

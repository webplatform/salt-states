
/etc/nginx/sites-enabled/source:
  file.managed:
    - source: salt://phabricator/files/nginx.project.jinja
    - template: jinja
    - context:
        subDomainName: project

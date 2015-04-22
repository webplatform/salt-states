include:
  - nginx

/etc/nginx/sites-available/project:
  file.managed:
    - source: salt://phabricator/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        subDomainName: project
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-project:
  file.symlink:
    - target: /etc/nginx/sites-available/project
    - require:
      - file: /etc/nginx/sites-available/project


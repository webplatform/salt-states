include:
  - nginx

/etc/nginx/sites-available/project:
  file.managed:
    - source: salt://buggenie/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        subDomainName: project
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-project:
  file.symlink:
    - target: /etc/nginx/sites-available/project
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/project


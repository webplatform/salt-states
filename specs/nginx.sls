include:
  - nginx

/etc/nginx/sites-available/specs:
  file.managed:
    - source: salt://specs/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        subDomainName: specs
        publican_backend_host: {{ salt['pillar.get']('infra:publican:host', '127.0.0.1') }}
        publican_backend_port: {{ salt['pillar.get']('infra:publican:port', 7002) }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/10-specs:
  file.symlink:
    - target: /etc/nginx/sites-available/specs
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/specs
    - watch_in:
      - service: nginx


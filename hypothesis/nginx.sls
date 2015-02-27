include:
  - nginx

/etc/nginx/sites-available/notes:
  file.managed:
    - source: salt://hypothesis/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        subDomainName: notes
        hypothesis_host: {{ salt['pillar.get']('infra:notes-server:host', '127.0.0.1') }}
        hypothesis_port: {{ salt['pillar.get']('infra:notes-server:port', 8000) }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-notes:
  file.symlink:
    - target: /etc/nginx/sites-available/notes
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/notes


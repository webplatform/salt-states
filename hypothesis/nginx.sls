include:
  - nginx

/etc/nginx/sites-enabled/notes:
  file.managed:
    - source: salt://hypothesis/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        hypothesis_host: {{ salt['pillar.get']('infra:notes-server:host', '127.0.0.1') }}
        hypothesis_port: {{ salt['pillar.get']('infra:notes-server:port', 8000) }}
    - watch_in:
      - service: nginx


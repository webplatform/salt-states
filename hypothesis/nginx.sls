include:
  - nginx

/etc/nginx/sites-enabled/notes:
  file.managed:
    - source: salt://hypothesis/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        hypothesis_host: {{ salt['pillar.get']('infra:notes:host', '127.0.0.1') }}
        hypothesis_port: {{ salt['pillar.get']('infra:notes:port', 8000) }}


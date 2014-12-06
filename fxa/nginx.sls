include:
  - nginx

/etc/nginx/sites-enabled/accounts:
  file.managed:
    - source: salt://fxa/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
    - watch_in:
      - service: nginx


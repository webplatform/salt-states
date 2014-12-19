include:
  - nginx

/etc/nginx/sites-enabled/accounts:
  file.managed:
    - source: salt://fxa/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        fxa_auth_host: 127.0.0.1
        fxa_auth_port: 9000
        fxa_oauth_host: 127.0.0.1
        fxa_oauth_port: 9010
        fxa_profile_host: 127.0.0.1
        fxa_profile_port: 1111
#        fxa_profile_port: 8081
        fxa_content_host: 127.0.0.1
        fxa_content_port: 3030
    - watch_in:
      - service: nginx


{%- set infra_pillar    = salt['pillar.get']('infra:auth-server') %}

include:
  - nginx

/etc/nginx/sites-enabled/accounts:
  file.managed:
    - source: salt://fxa/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        infra_pillar: {{ infra_pillar }}
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
    - watch_in:
      - service: nginx


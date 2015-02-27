{%- set infra_pillar    = salt['pillar.get']('infra:auth-server') %}

include:
  - nginx

/etc/nginx/sites-available/accounts:
  file.managed:
    - source: salt://fxa/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        infra_pillar: {{ infra_pillar }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-accounts:
  file.symlink:
    - target: /etc/nginx/sites-available/accounts
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/accounts


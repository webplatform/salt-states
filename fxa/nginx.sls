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
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/10-accounts:
  file.symlink:
    - target: /etc/nginx/sites-available/accounts
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/accounts

/etc/nginx/sites-available/accounts-apis:
  file.managed:
    - source: salt://fxa/files/vhost-apis.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        infra_pillar: {{ infra_pillar }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/10-accounts-apis:
  file.symlink:
    - target: /etc/nginx/sites-available/accounts-apis
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/accounts-apis

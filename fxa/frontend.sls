{%- set infra_pillar = salt['pillar.get']('infra:auth-server') %}

include:
  - nginx

/etc/nginx/sites-available/accounts:
  file.managed:
    - source: salt://fxa/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        infra_pillar: {{ infra_pillar }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-accounts:
  file.symlink:
    - target: /etc/nginx/sites-available/accounts
    - require:
      - file: /etc/nginx/sites-available/accounts

/etc/nginx/sites-available/accounts-apis:
  file.managed:
    - source: salt://fxa/files/nginx.frontend-apis.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        infra_pillar: {{ infra_pillar }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-accounts-apis:
  file.symlink:
    - target: /etc/nginx/sites-available/accounts-apis
    - require:
      - file: /etc/nginx/sites-available/accounts-apis


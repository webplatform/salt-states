{%- set accounts_pillar = salt['pillar.get']('accounts:auth-server') -%}
{%- set infra_pillar = salt['pillar.get']('infra:auth-server') %}

include:
  - rsync.secret
  - code.prereq
  - code.certificates
  - users.app-user

# @salt-master-dest
sync-fxa-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@salt::code/packages/auth-server/dists/ /srv/webplatform/appshomedir/dists/auth-server/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/appshomedir/dists/auth-server
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/appshomedir/dists/auth-server
    - user: app-user
    - group: www-data
    - makedirs: True
    - require:
      - file: /srv/webplatform/appshomedir
      - user: app-user
    - recurse:
      - user
      - group


{% set configFiles = [
        ('profile', 'config/prod.json'),
        ('oauth',   'config/prod.json'),
        ('content', 'server/config/production.json'),
        ('auth',    'config/prod.json') ] %}
{% for appName, file in configFiles %}
/srv/webplatform/auth-server/{{ appName }}:
  file.directory:
    - makedirs: True

/srv/webplatform/auth-server/{{ appName }}/{{ file }}:
  file.managed:
    - source: salt://code/files/auth-server/fxa-{{ appName }}-server.json.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - create: False
    - context:
        accounts_pillar: {{ accounts_pillar }}
        infra_pillar: {{ infra_pillar }}
        masterdb_ip: {{ salt['pillar.get']('infra:db_servers:mysql:masterdb', '127.0.0.1') }}
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        oauth_clients: {{ salt['pillar.get']('accounts:auth-server:oauth:clients', []) }}
    - require:
      - file: /srv/webplatform/auth-server/{{ appName }}

{% endfor %}

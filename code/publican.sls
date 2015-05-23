{%- set dir = '/srv/webapps/publican' -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set upstream_port = salt['pillar.get']('upstream:publican:port', 8002) -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
{%- set fastly = salt['pillar.get']('accounts:fastly:specs') %}

{{ dir }}:
  file.directory:
    - user: webapps
    - group: webapps
    - recurse:
      - user
      - group

{{ dir }}/data:
  file.directory:
    - user: webapps
    - group: webapps

{{ dir }}/spec-data:
  file.directory:
    - user: webapps
    - group: webapps

{{ dir }}/docker-compose.yml:
  file.managed:
    - source: salt://code/files/publican/docker-compose.yml.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - mode: 644
    - context:
        upstream_port: {{ upstream_port }}
        salt_master_ip: {{ salt_master_ip }}
    - require:
      - file: {{ dir }}

{{ dir }}/data/config.json:
  file.managed:
    - source: salt://code/files/publican/config.json.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - context:
        tld: {{ tld }}
        fastly_secret: {{ fastly.secret|default('pillar_accounts_fastly_specs_secret_absent') }}
        fastly_service: {{ fastly.service|default('pillar_accounts_fastly_specs_service_absent') }}
        smtp: {{ smtp }}

# @salt-master-dest
rsync-bikeshed-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@salt::code/packages/bikeshed/dists/ /srv/webplatform/appshomedir/dists/bikeshed/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/appshomedir/dists/bikeshed
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/appshomedir/dists/bikeshed
    - user: app-user
    - group: w3t
    - makedirs: True
    - require:
      - file: /srv/webplatform/appshomedir
      - user: app-user
    - recurse:
      - user
      - group

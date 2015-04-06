{%- set dir = '/srv/webplatform/publican' -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
{%- set backend_port = salt['pillar.get']('infra:backends:port:publican', 8002) %}

include:
  - users.app-user

{{ dir }}:
  file.directory:
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group

{{ dir }}/docker-compose.yml:
  file.managed:
    - source: salt://code/files/publican/docker-compose.yml.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - mode: 644
    - context:
        tld: {{ tld }}
        smtp: {{ smtp }}
        backend_port: {{ backend_port }}
    - require:
      - file: {{ dir }}


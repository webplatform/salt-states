{%- set level = salt['grains.get']('level', 'production') -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') %}

include:
  - code.prereq

{% set unpack = salt['pillar.get']('basesystem:notes:unpacker_archives') %}
{% from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}
{{ unpack_remote_loop(unpack)}}

/srv/webplatform/notes-server/h.ini:
  file.managed:
    - template: jinja
    - source: salt://code/files/notes-server/h.ini.jinja
    - user: webapps
    - group: webapps
    - require:
      - file: Packager unpack /srv/webplatform/notes-server
    - context:
        ## Expected keys: public_url, port, host, elastic_endpoint, sender_email
        notes_server_pillar: {{ salt['pillar.get']('infra:notes-server') }}
        ## Expected keys: auth, token, session, session_read, session_recover
        auth_server_endpoints: {{ salt['pillar.get']('infra:auth-server:endpoints') }}
        ## Expected keys: auth_client_id, auth_client_secret, secret
        notes_secrets_pillar: {{ salt['pillar.get']('accounts:notes-server') }}
        smtp: {{ smtp }}

/srv/webplatform/notes-server/service.sh:
  file.managed:
    - source: salt://code/files/notes-server/service.sh
    - mode: 755
    - user: webapps
    - group: webapps
    - require:
      - file: Packager unpack /srv/webplatform/notes-server

{%- set dir = '/srv/webapps/parsoid' -%}
{%- set upstream_port = salt['pillar.get']('upstream:parsoid:port', 8007) -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set internal_docs_ip = salt['pillar.get']('infra:hardcoded_entries:docs') %}

{{ dir }}/Dockerfile:
  file.managed:
    - source: salt://code/files/parsoid/Dockerfile
    - user: webapps
    - group: webapps

{{ dir }}/Makefile:
  file.managed:
    - source: salt://code/files/parsoid/Makefile.jinja
    - template: jinja
    - user: webapps
    - group: webapps
    - context:
        upstream_port: {{ upstream_port }}
        tld: {{ tld }}
        internal_docs_ip: {{ internal_docs_ip }}


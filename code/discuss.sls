{%- set dir = '/srv/webapps/discuss' -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
{%- set upstream_port = salt['pillar.get']('upstream:discourse:port', 8001) -%}
{%- set db = salt['pillar.get']('accounts:discourse:db') -%}
{%- set postgres_ip = salt['pillar.get']('infra:db_servers:postgres:writes') -%}
{%- set alpha_redis = salt['pillar.get']('infra:alpha_redis', ['127.0.0.1:6379']) %}

include:
  - code.prereq

{{ dir }}:
  file.directory:
    - makedirs: True

{% set unpack = salt['pillar.get']('basesystem:docker:discuss:git_clone') %}
{% from "basesystem/macros/git.sls" import git_clone_loop %}
{{ git_clone_loop(unpack)}}

{% if db %}
{{ dir }}/containers/app.yml:
  file.managed:
    - template: jinja
    - source: salt://code/files/discuss/app.yml.jinja
    - user: webapps
    - group: webapps
    - context:
        tld: {{ tld }}
        level: {{ level }}
        dir: {{ dir }}
        smtp: {{ smtp }}
        alpha_redis: {{ alpha_redis }}
        upstream_port: {{ upstream_port }}
        db: {{ db }}
        postgres_ip: {{ postgres_ip }}
{% endif %}

discuss-deps:
  pkg.installed:
    - pkgs:
      - libpam-cracklib

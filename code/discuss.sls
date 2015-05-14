{%- set dir = '/srv/webapps/discuss' -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set smtp = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
{%- set upstream_port = salt['pillar.get']('upstream:discourse:port', 8001) -%}
{%- set db = salt['pillar.get']('accounts:discourse:db') -%}
{%- set alpha_redis = salt['pillar.get']('infra:alpha_redis') %}

include:
  - code.prereq

{{ dir }}:
  file.directory:
    - makedirs: True

# salt notes git.clone /srv/webplatform/notes-server https://github.com/webplatform/annotation-service.git user="renoirb"
clone-discuss:
  pkg.installed:
    - name: git
  git.latest:
    - name: https://github.com/discourse/discourse_docker.git
    - user: webapps
    - target: {{ dir }}
    - unless: test -f {{ dir }}/containers/app.yml
    - require:
      - file: {{ dir }}
      - pkg: git
  file.directory:
    - name: {{ dir }}
    - require:
      - file: webplatform-sources
    - user: webapps
    - group: webapps
    - recurse:
      - user
      - group

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

discuss-deps:
  pkg.installed:
    - pkgs:
      - libpam-cracklib


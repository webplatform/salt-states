{%- set svc = ['fxa-profile-server', 'fxa-content-server', 'fxa-auth-server', 'fxa-oauth-server'] -%}
{%- set svc_user = 'app-user' -%}
{%- set svc_group = 'www-data' -%}
include:
  - nodejs
  - users.app-user
  - .monit

fxa-dependencies:
  pkg.installed:
    - pkgs:
      - libgmp-dev
      - git
      - make
      - build-essential
      - nodejs
      - nodejs-legacy
      - npm

fxa-nodejs-deps:
  npm.installed:
    - pkgs:
      - grunt-cli
      - bower
      - bunyan
      - forever
    - require:
      - pkg: fxa-dependencies

{% for serviceName in svc %}
/etc/init/{{ serviceName }}.conf:
  file.managed:
    - source: salt://fxa/files/{{ serviceName }}.init
    - template: jinja
    - context:
        svc_user: {{ svc_user }}
        svc_group: {{ svc_group }}
    - require:
      - pkg: monit
      - pkg: nodejs

/srv/webplatform/auth-server/{{ serviceName }}:
  file.directory:
    - user: {{ svc_user }}
    - group: {{ svc_group }}
    - require:
      - file: /etc/init/{{ serviceName }}.conf
    - makedirs: True
    - recurse:
      - user
      - group
{% endfor %}

/var/log/fxa:
  file.directory:
    - makedirs: True
    - user: {{ svc_user }}
    - group: {{ svc_group }}


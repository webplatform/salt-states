{%- set svc = ['profile', 'content', 'auth', 'oauth'] -%}
{%- set svc_user = 'webapps' -%}
{%- set svc_group = 'webapps' -%}

include:
  - webplatform
  - nodejs
  - .monit

fxa-dependencies:
  pkg.installed:
    - pkgs:
      - libgmp-dev
      - git
      - make

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
/etc/init/fxa-{{ serviceName }}.conf:
  file.managed:
    - source: salt://fxa/files/init.{{ serviceName }}.jinja
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
      - file: /etc/init/fxa-{{ serviceName }}.conf
    - makedirs: True
    - recurse:
      - user
      - group
{% endfor %}


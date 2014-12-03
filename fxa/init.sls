{% set svc = ['fxa-profile-server', 'fxa-content-server', 'fxa-auth-server', 'fxa-oauth-server'] -%}
include:
  - nodejs

fxa-deps:
  pkg.installed:
    - names:
      - monit
      - libgmp-dev

fxa-nodejs-deps:
  npm.installed:
    - names:
      - grunt-cli
      - bower
      - bunyan
      - forever
    - require:
      - pkg: fxa-deps

{% for service in svc %}
/etc/init/{{ service }}.conf:
  file.managed:
    - source: salt://fxa/files/{{ service }}.init
    - require:
      - pkg: monit
{% endfor %}

{% for service in svc %}
/etc/monit/conf.d/{{ service }}:
  file.managed:
    - source: salt://fxa/files/monit/{{ service }}
    - require:
      - pkg: monit
    - require_in:
      - service: monit
{% endfor %}

monit:
  service:
    - running

{% for service in svc %}
/srv/webplatform/auth/{{ service }}:
  file.directory:
    - user: ubuntu
    - group: ubuntu
    - require:
      - file: /etc/init/{{ service }}.conf
{% endfor %}

/etc/monit/conf.d/auth:
  file.managed:
    - source: salt://fxa/files/monit/auth.jinja
    - template: jinja
    - require:
      - pkg: monit

/var/log/fxa/:
  file:
    - directory
    - user: ubuntu
    - group: ubuntu

/srv/webplatform/auth/profile-check.sh:
  file.managed:
    - source: salt://fxa/files/wpd-check.sh.jinja
    - template: jinja
    - user: ubuntu
    - group: ubuntu
    - mode: 755
    - require_in:
      - file: /etc/monit/conf.d/fxa-profile-server

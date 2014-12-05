{% set svc = ['fxa-profile-server', 'fxa-content-server', 'fxa-auth-server', 'fxa-oauth-server'] -%}
include:
  - nodejs
  - mmonit

libgmp-dev:
  pkg.installed

fxa-nodejs-deps:
  npm.installed:
    - pkgs:
      - grunt-cli
      - bower
      - bunyan
      - forever
    - require:
      - pkg: libgmp-dev

{% for service in svc %}
/etc/init/{{ service }}.conf:
  file.managed:
    - source: salt://fxa/files/{{ service }}.init
    - require:
      - pkg: monit

/etc/monit/conf.d/{{ service }}:
  file.managed:
    - source: salt://fxa/files/monit/{{ service }}
    - require:
      - pkg: monit
    - require_in:
      - service: monit

/srv/webplatform/auth/{{ service }}:
  file.directory:
    - user: dhc-user
    - group: dhc-user
    - require:
      - file: /etc/init/{{ service }}.conf
{% endfor %}

/var/log/fxa/:
  file:
    - directory
    - user: dhc-user
    - group: dhc-user

/srv/webplatform/auth/profile-check.sh:
  file.managed:
    - source: salt://fxa/files/wpd-check.sh.jinja
    - template: jinja
    - user: dhc-user
    - group: dhc-user
    - mode: 755
    - require_in:
      - file: /etc/monit/conf.d/fxa-profile-server

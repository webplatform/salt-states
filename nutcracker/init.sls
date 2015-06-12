# https://github.com/twitter/twemproxy#configuration
# https://github.com/wikimedia/operations-puppet  in modules/nutcracker/
include:
  - mmonit

/etc/nutcracker/conf:
  file.directory:
    - makedirs: true
    - user: webapps
    - group: webapps

/etc/nutcracker/conf/nutcracker.yml:
  file:
    - managed
    - mode: 444
    - user: webapps
    - group: webapps
    - source: salt://nutcracker/files/config.yml.jinja
    - template: jinja

/etc/default/twemproxy:
  file.managed:
    - contents: |
        DAEMON_ARGS="-v 6 -c /etc/nutcracker/conf/nutcracker.yml"

# Relies on https://static.webplatform.org/wpd/packages/apt/twemproxy_0.4.0-2~ubuntu14.04.1_amd64.deb
# look at /etc/apt/sources.list.d/webplatform.list
twemproxy:
  pkg.installed:
    - skip_verify: True
  service.running:
    - enable: True
    - reload: True

/etc/monit/conf.d/nutcracker.conf:
  file.managed:
    - source: salt://nutcracker/files/monit.conf
    - watch_in:
      - service: monit


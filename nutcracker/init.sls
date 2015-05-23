# https://github.com/twitter/twemproxy#configuration
# https://github.com/wikimedia/operations-puppet  in modules/nutcracker/
include:
  - mmonit

# https://launchpad.net/~twemproxy/+archive/ubuntu/stable
# add-apt-repository -y ppa:twemproxy/stable

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


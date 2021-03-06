# https://github.com/twitter/twemproxy#configuration
# https://github.com/wikimedia/operations-puppet  in modules/nutcracker/
include:
  - mmonit
  - code.packages

# https://launchpad.net/~twemproxy/+archive/ubuntu/stable
# add-apt-repository -y ppa:twemproxy/stable

nutcracker:
  pkg.installed:
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list
      - file: /etc/nutcracker/conf/nutcracker.yml
  service.running:
    - enable: True
    - reload: True
    - require:
      - file: /etc/init/nutcracker.conf
      - file: /etc/nutcracker/conf/nutcracker.yml

/etc/nutcracker/conf:
  file.directory:
    - makedirs: true
    - user: nobody
    - group: www-data

/etc/nutcracker/conf/nutcracker.yml:
  file:
    - managed
    - mode: 444
    - user: nobody
    - group: www-data
    - source: salt://nutcracker/files/config.yml.jinja
    - template: jinja
    - require:
      - file: /etc/nutcracker/conf
    - watch_in:
      - service: nutcracker

/etc/init/nutcracker.conf:
  file.managed:
    - source: salt://nutcracker/files/upstart.conf
    - watch_in:
      - service: nutcracker

/etc/monit/conf.d/nutcracker.conf:
  file.managed:
    - source: salt://nutcracker/files/monit.conf
    - watch_in:
      - service: monit

/usr/bin/wpd-nutcracker-monitor.py:
  file.managed:
    - source: salt://nutcracker/files/NutcrackerMonitor/ballgazer.py
    - mode: 755


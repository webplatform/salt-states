# https://github.com/twitter/twemproxy#configuration
# https://github.com/wikimedia/operations-puppet  in modules/nutcracker/

include:
  - mmonit
  - code.packages

nutcracker:
  pkg.installed:
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list
      - file: /etc/nutcracker/conf/nutcracker.yml
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nutcracker/conf/nutcracker.yml
    - require:
      - file: /etc/init/nutcracker.conf

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

/etc/init/nutcracker.conf:
  file.managed:
    - source: salt://nutcracker/files/nutcracker.init

/etc/monit/conf.d/nutcracker.conf:
  file.managed:
    - source: salt://nutcracker/files/monit.conf
    - require:
      - service: monit

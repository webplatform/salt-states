# https://github.com/twitter/twemproxy#configuration
# https://github.com/wikimedia/operations-puppet  in modules/nutcracker/

include:
  - mmonit

/etc/nutcracker/conf:
  file.directory:
    - makedirs: true
    - user: nobody
    - group: www-data
    - require:
      - cmd: nutcracker-pkg-installed

nutcracker-pkg-installed:
  cmd.run:
    - name: "dpkg-query -Wf'${db:Status-abbrev}' nutcracker 2>/dev/null | grep -q '^i'  #ADVICE: Make sure you installed manually nutcracker from code.packages"

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
  service.running:
    - name: nutcracker
    - enable: True
    - watch:
        - file: /etc/nutcracker/conf/nutcracker.yml
    - reload: True

/etc/monit/conf.d/nutcracker.conf:
  file.managed:
    - source: salt://nutcracker/files/monit.conf
    - require:
      - service: monit

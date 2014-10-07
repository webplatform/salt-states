# https://github.com/twitter/twemproxy#configuration
# https://github.com/wikimedia/operations-puppet  in modules/nutcracker/

/etc/default/nutcracker:
  file:
    - managed
    - contents: |
        # Managed by Salt Stack, DO NOT EDIT MANUALLY
        DAEMON_OPTS="--mbuf-size=65536 --stats-port=22223 -c /etc/nutcracker/conf/nutcracker.yml"

/etc/nutcracker/conf/nutcracker.yml:
  file:
    - managed
    - mode: 444
    - source: salt://nutcracker/files/config.yml.jinja
    - template: jinja
    - createdirs: True
    - require:
      - file: /etc/default/nutcracker

#/etc/init/nutcracker.conf:
#  service.running:
#    - name: nutcracker
#    - enable: True
#    - watch:
#        - file: /etc/default/nutcracker
#        - file: /etc/nutcracker/nutcracker.yml
#    - reload: True

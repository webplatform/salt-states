#
# Monit service health checks
#
# Ref:
#   - https://mmonit.com/monit/documentation/monit.html
#
{%- set level = salt['grains.get']('level', 'production') %}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set monit_pw = salt['pillar.get']('accounts:monit:admin_password', 'somethingrandom') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt', '127.0.0.1') %}

monit:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: monit

/etc/monit/conf.d/defaults.conf:
  file.managed:
    - source: salt://mmonit/files/defaults.conf.jinja
    - template: jinja
    - require:
      - pkg: monit
      - file: /etc/monit/conf.d
    - watch_in:
      - service: monit
    - context:
        level: {{ level }}
        tld: {{ tld }}
        fqdn: {{ grains['fqdn'] }}
        monit_pw: {{ monit_pw }}
        monit_port: 2812
        salt_master_ip: {{ salt_master_ip }}
  cmd.run:
    - name: /usr/bin/monit -t
    - watch_in:
      - service: monit

/etc/monit/conf.d:
  file.directory:
    - file_mode: 600
    - recurse:
      - mode
    - require:
      - pkg: monit
    - watch_in:
      - service: monit


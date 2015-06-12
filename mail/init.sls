{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}

#
# Ref:
#   - https://github.com/Exim/exim/wiki/EximSecurity
#   - http://www.exim.org/exim-html-current/doc/html/spec_html/ch-security_considerations.html
#   - http://www.exim.org/exim-html-current/doc/html/spec_html/ch-the_exim_run_time_configuration_file.html
#

include:
  - mmonit

/etc/mailname:
  file.managed:
    - source: salt://mail/mailname
    - template: jinja
    - context:
        tld: {{ tld }}
    - user: root
    - group: root
    - mode: 644

/etc/exim4/update-exim4.conf.conf:
  file.managed:
    - source: salt://mail/files/update-exim4.conf.conf.jinja
    - user: root
    - group: root
    - template: jinja
    - require:
      - pkg: exim4
    - context:
        tld: {{ tld }}
        fqdn: {{ grains['fqdn'] }}

/usr/sbin/update-exim4.conf:
  cmd.wait:
    - user: root
    - group: root
    - watch:
      - file: /etc/exim4/update-exim4.conf.conf
      - file: /etc/mailname
    - require:
      - pkg: exim4

exim4:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: exim4

/etc/monit/conf.d/mail.conf:
  file.managed:
    - source: salt://mail/files/exim4/monit.conf
    - watch_in:
      - service: monit


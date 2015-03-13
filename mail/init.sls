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
    - user: root
    - group: root
    - mode: 644

/etc/exim4/passwd.client:
  file.managed:
    - source: salt://mail/files/passwd.client.jinja
    - template: jinja
    - user: root
    - group: Debian-exim
    - mode: 640
    - require:
      - pkg: exim4
    - context:
        smarthost: {{ salt['pillar.get']('accounts:smtp:host', 'localhost') }}
        username: {{ salt['pillar.get']('accounts:smtp:username', '') }}
        password: {{ salt['pillar.get']('accounts:smtp:password', '') }}

/etc/exim4/update-exim4.conf.conf:
  file.managed:
    - source: salt://mail/files/update-exim4.conf.conf.jinja
    - user: root
    - group: root
    - template: jinja
    - require:
      - pkg: exim4
    - context:
        topLevelDomain: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
        fqdn: {{ salt['grains.get']('fqdn') }}
        smarthost: {{ salt['pillar.get']('accounts:smtp:host', 'localhost') }}

/usr/sbin/update-exim4.conf:
  cmd.wait:
    - user: root
    - group: root
    - watch:
      - file: /etc/exim4/update-exim4.conf.conf
      - file: /etc/mailname
      - file: /etc/exim4/passwd.client
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


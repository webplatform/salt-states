/etc/mailname:
  file.managed:
    - source: salt://mail/mailname
    - user: root
    - group: root
    - mode: 644

#/etc/exim4/passwd.client:
#  file.managed:
#    - source: salt://mail/passwd.client
#    - template: jinja
#    - user: root
#    - group: Debian-exim
#    - mode: 640
#    - require:
#      - pkg: exim4

/etc/exim4/update-exim4.conf.conf:
  file.managed:
    - source: salt://mail/update-exim4.conf.conf
    - user: root
    - group: root
    - template: jinja
    - require:
      - pkg: exim4

/usr/sbin/update-exim4.conf:
  cmd.wait:
    - user: root
    - group: root
    - watch:
      - file: /etc/exim4/update-exim4.conf.conf
      - file: /etc/mailname
#      - file: /etc/exim4/passwd.client
    - require:
      - pkg: exim4

exim4:
  pkg:
    - installed
  service.running:
    - enable: true
    - require:
      - pkg: exim4

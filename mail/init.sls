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
        smarthost: mailtrap.io
        username: 263449d09cda1e8fd
        password: 34fb58c208f207

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
        smarthost: mailtrap.io

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

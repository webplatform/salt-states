{#
 # WebPlatform SMTP relay
 #
 # Ref:
 #   - http://www.amavis.org/README.postfix.html
 #}
include:
  - mail
  - postfix
  - mmonit

exclude:
  - id: /etc/exim4/passwd.client
  - id: /etc/exim4/update-exim4.conf.conf
  - id: /usr/sbin/update-exim4.conf
  - id: exim4

purge-exim:
  pkg.purged:
    - pkgs:
      - exim4
      - exim4-base
      - exim4-config
      - exim4-daemon-light

mailhub-required-pkgs:
  pkg.installed:
    - pkgs:
      - amavisd-new
      - spamassassin
      - clamav-daemon
      - libnet-dns-perl
      - pyzor
      - razor
      - arj
      - bzip2
      - zoo
      - cabextract
      - unrar-free
      - unzip
      - zip
      - p7zip-full
      - p7zip
      - cpio
      - file
      - gzip
      - nomarch
      - unp
      - pax
      - clamav-freshclam
      - librrds-perl
      - clamav
      - libnet-cidr-perl
      - libmail-dkim-perl
      - libio-multiplex-perl
      - libcrypt-openssl-rsa-perl
      - libcrypt-openssl-bignum-perl
      - libmime-tools-perl
      - libio-stringy-perl
      - cabextract
      - ripole
      - spamc
      - dkms
      - spfquery
      - spf-tools-perl
      - opendkim
      - opendkim-tools
      - swaks

mailgraph-viewer:
  pkg.installed:
    - pkgs:
      - mailgraph
      - apache2
    - require:
      - pkg: mailhub-required-pkgs
  service.running:
    - name: apache2
    - reload: True
    - enable: True
  cmd.run:
    - name: a2enmod cgid
    - unless: test -f /etc/apache2/mods-enabled/cgid.load
  file.managed:
    - name: /etc/apache2/sites-enabled/000-default.conf
    - source: salt://mail/files/mailhub/apache2.vhost.conf.jinja
    - template: jinja
    - watch_in:
      - service: mailgraph-viewer

opendkim:
  pkg.installed:
    - pkgs:
      - opendkim-tools
      - opendkim
    - require:
      - pkg: mailhub-required-pkgs
  service.running:
    - enable: True
    - reload: True

dovecot-core:
  pkg.installed:
    - pkgs:
      - dovecot-sieve
      - dovecot-core
      - dovecot-common
    - require:
      - pkg: mailhub-required-pkgs
  service.running:
    - name: dovecot
    - enable: True
    - reload: True

/etc/apache2/conf-enabled/performance.conf:
  file.managed:
    - contents: |
        ServerName            {{ salt['grains.get']('nodename') }}
        ServerLimit           2
        MaxRequestWorkers     25
    - watch_in:
      - service: mailgraph-viewer

{%- set services = ['spamassassin','clamav-daemon','amavis'] -%}
{%- for svcName in services %}
{{ svcName }}:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: mailhub-required-pkgs
{% endfor %}

usermod -a -G amavis clamav:
  cmd.run:
    - unless: grep -q -e '^amavis.*clamav$' /etc/group
    - require_in:
      - service: clamav-daemon

/etc/default/opendkim:
  file:
    - uncomment
    - regex: SOCKET="local:/var/run/opendkim/opendkim.sock"
    - require_in:
      - service: opendkim

postfix-access-opendkim:
  user.present:
    - name: postfix
    - require:
      - pkg: mailhub-required-pkgs
      - file: /etc/default/opendkim
    - groups:
      - opendkim

/etc/amavis/conf.d/05-node_id:
  file.managed:
    - source: salt://mail/files/amavis/conf.d/node_id
    - require:
      - pkg: mailhub-required-pkgs

/etc/amavis/conf.d/15-content_filter_mode:
  file.managed:
    - source: salt://mail/files/amavis/conf.d/content_filter_mode
    - require:
      - pkg: mailhub-required-pkgs

## Not enabling it because first run is long
#Freshclam first run:
#  cmd.run:
#    - unless: test -d /var/lib/clamav
#    - name: freshclam
#    - require_in:
#      - service: clamav-daemon

extend:
  /etc/monit/conf.d/mail.conf:
    file.managed:
      - source: salt://mail/files/mailhub/monit.conf.jinja


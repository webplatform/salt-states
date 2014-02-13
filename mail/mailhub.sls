exclude:
  - id: /etc/exim4/passwd.client
  - id: /etc/exim4/update-exim4.conf.conf
  - id: /usr/sbin/update-exim4.conf
  - id: exim4

include:
  - postfix

purge-exim:
  pkg.purged:
    - pkgs:
      - exim4
      - exim4-base
      - exim4-config
      - exim4-daemon-light

mailhub-required-pkgs:
  pkg.installed:
    - names:
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
      - mailgraph
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
      - dovecot-sieve
      - dovecot-core
      - dovecot-common
      - ripole
      - spamc
      - dkms
      - spfquery
      - spf-tools-perl
      - opendkim
      - opendkim-tools

refresh-clam:
  cmd:
    - run
    - name: freshclam
    - require:
      - pkg: clamav-freshclam

mailhub-services:
  service:
    - running
    - names:
      - spamassassin
      - opendkim
      - clamav-daemon
      - amavis
      - dovecot
    - enable: True
    - reload: true
    - require:
      - pkg: spamassassin
      - pkg: opendkim
      - pkg: clamav-daemon
      - pkg: amavisd-new
      - pkg: dovecot-core
    - watch:
      - pkg: spamassassin
      - pkg: opendkim
      - pkg: clamav-daemon
      - pkg: amavisd-new
      - pkg: dovecot-core

usermod -a -G amavis clamav:
  cmd:
    - run
    - require:
      - pkg: clamav
      - pkg: amavisd-new

/etc/default/opendkim:
  file:
    - uncomment
    - regex: SOCKET="local:/var/run/opendkim/opendkim.sock"
    - require:
      - pkg: opendkim

postfix-access-opendkim:
  user.present:
    - name: postfix
    - require:
      - pkg: postfix
      - pkg: opendkim
      - file: /etc/default/opendkim
    - groups:
      - opendkim

/etc/amavis/conf.d/05-node_id:
  file.managed:
    - source: salt://mail/files/amavis/conf.d/node_id
    - require:
      - pkg: amavisd-new

/etc/amavis/conf.d/15-content_filter_mode:
  file.managed:
    - source: salt://mail/files/amavis/conf.d/content_filter_mode
    - require:
      - pkg: amavisd-new

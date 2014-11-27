include:
  - rsync.secret
  - code.prereq
  - mail.mailhub

# @salt-master-dest
sync-hub-configs:
  cmd.run:
    - name: rsync -a --exclude '.git' --delete --password-file=/etc/codesync.secret codesync@salt::code/mailhub/repo/ /srv/webplatform/mailhub/
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/mailhub/
    - user: root
    - group: root
    - dir_mode: 0755
    - file_mode: 0644
    - require:
      - cmd: sync-hub-configs
    - recurse:
      - user
      - group
      - mode

postfix-dir:
  file.symlink:
    - name: /etc/postfix
    - target: /srv/webplatform/mailhub/etc/postfix
    - backupname: /etc/postfix.orig
    - force: True
    - require:
      - cmd: sync-hub-configs
      - sls: mail.mailhub
    - watch_in:
      - service: postfix

/etc/opendkim.conf:
  file.symlink:
    - target: /srv/webplatform/mailhub/etc/opendkim.conf
    - backupname: /etc/opendkim.conf.orig
    - force: True
    - require:
      - cmd: sync-hub-configs
      - file: /var/log/dkim-filter

/var/log/dkim-filter:
  file.directory:
    - user: opendkim
    - group: opendkim
    - dir_mode: 0755
    - file_mode: 0644
    - recurse:
      - user
      - group
      - mode
    - require:
      - pkg: opendkim

opendkim-dir:
  file.symlink:
    - name: /etc/opendkim
    - target: /srv/webplatform/mailhub/etc/opendkim
    - backupname: /etc/opendkim.orig
    - force: True
    - require:
      - cmd: sync-hub-configs

adjust-perms-opendkim-certs:
  file.directory:
    - name: /srv/webplatform/mailhub/etc/opendkim/certs
    - user: opendkim
    - group: opendkim
    - dir_mode: 700
    - file_mode: 600
    - recurse:
      - user
      - group
      - mode
    - require:
      - file: opendkim-dir

adjust-perms-postfix:
  file.directory:
    - name: /srv/webplatform/mailhub/etc/postfix
    - user: root
    - group: root
    - recurse:
      - user
      - group
    - require:
      - file: postfix-dir

adjust-perms-certs:
  file.directory:
    - name: /srv/webplatform/mailhub/etc/postfix/certs
    - user: postfix
    - group: postfix
    - file_mode: 600
    - dir_mode: 700
    - recurse:
      - user
      - group
      - mode
    - require:
      - file: adjust-perms-postfix

adjust-perms-opendkim:
  file.directory:
    - name: /srv/webplatform/mailhub/etc/opendkim
    - user: opendkim
    - group: opendkim
    - recurse:
      - user
      - group
    - require:
      - file: opendkim-dir

postfix-smtp-auth-patch:
  file.symlink:
    - target: /srv/webplatform/mailhub/etc/dovecot/conf.d/10-master.conf
    - name: /etc/dovecot/conf.d/10-master.conf
    - force: True
    - require:
      - pkg: dovecot-core
      - cmd: sync-hub-configs

for f in `ls -1 *.db | sed 's/.db//'`; do postmap $f ; done:
  cmd:
    - run
    - cwd: /srv/webplatform/mailhub/etc/postfix
    - require:
      - file: postfix-dir

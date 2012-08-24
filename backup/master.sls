include:
  - rsync.secret

rsync -a --no-perms --password-file=/etc/backup.secret backup@deployment.webplatform.org::backup/ /mnt/backup/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/backup.secret

rsync -a --no-perms --password-file=/etc/backup.secret backup@db1.webplatform.org::backup/ /mnt/backup/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/backup.secret


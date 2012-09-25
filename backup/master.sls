include:
  - rsync.secret

backupdeployment:
  cron.present:
    - user: root
    - minute: 1
    - hour: 2
    - name: 'rsync -a --no-perms --password-file=/etc/backup.secret backup@deployment.webplatform.org::backup/ /mnt/backup/'
    - require:
      - file: /etc/backup.secret
      - file: /mnt/backup

backupdb:
  cron.present:
    - user: root
    - minute: 1
    - hour: 2
    - name: 'rsync -a --no-perms --password-file=/etc/backup.secret backup@db1.webplatform.org::backup/ /mnt/backup/'
    - require:
      - file: /etc/backup.secret
      - file: /mnt/backup

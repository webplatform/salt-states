include:
  - rsync.secret

backup_mount:
  mount.mounted:
    - name: /mnt/backup
    - device: /dev/backup1/lvbackup1
    - fstype: xfs
    - mkmnt: True
    - opts:
      - defaults

# Take LVM snapshots of the backup directory
backup_lvm_snapshot:
  cron.present:
    - user: root
    - minute: 1
    - hour: 4
    - name: 'lvcreate -L2G -s -n backup-snap`date "+%-d"` /dev/backup1/lvbackup1'

# Only keep snapshots for the last 4 days
remove_old_snapshots:
  cron.present:
    - user: root
    - minute: 1
    - hour: 5
    - name: '[ -f /dev/backup1/backup-snap`date --date="4 days ago" "+%-d"` ] && lvremove -f /dev/backup1/backup-snap`date --date="4 days ago" "+%-d"`'

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

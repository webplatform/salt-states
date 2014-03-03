include:
  - rsync.secret
  - cron
  - webplatform.swift-dreamobjects

backup_mount:
  mount.mounted:
    - name: /mnt/backup
    - device: /dev/backup1/lvbackup1
    - fstype: xfs
    - mkmnt: True
    - opts:
      - defaults

# Take LVM snapshots of the backup directory
#backup_lvm_snapshot:
#  cron.present:
#    - user: root
#    - minute: 1
#    - hour: 4
#    - name: 'lvcreate -L2G -s -n backup-snap`date "+%-d"` /dev/backup1/lvbackup1'

# Only keep snapshots for the last 4 days
#remove_old_snapshots:
#  cron.present:
#    - user: root
#    - minute: 1
#    - hour: 5
#    - name: '[ -f /dev/backup1/backup-snap`date --date="4 days ago" "+%-d"` ] && lvremove -f /dev/backup1/backup-snap`date --date="4 days ago" "+%-d"`'

backupdeployment:
  cron.present:
    - user: root
    - minute: 1
    - hour: 2
    - name: 'rsync -a --no-perms --password-file=/etc/backup.secret backup@deployment.dho.wpdn::backup/ /mnt/backup/'
    - require:
      - file: /etc/backup.secret
      - file: /mnt/backup

swift-upload:
  file.managed:
    - source: salt://backup/swift-upload.sh
    - mode: 755
    - name: /usr/local/sbin/swift-upload.sh
  cron.present:
    - user: root
    - minute: random
    - hour: 4
    - name: 'JOBNAME=swift-upload cronhelper.sh /usr/local/sbin/swift-upload.sh'
    - require:
      - file: /usr/bin/cronhelper.sh
      - file: /etc/profile.d/swift-dreamobjects.sh
      - file: /usr/local/sbin/swift-upload.sh

backupdb:
  cron.present:
    - user: root
    - minute: 1
    - hour: 2
    - name: 'rsync -a --no-perms --password-file=/etc/backup.secret backup@master.db.wpdn::backup/ /mnt/backup/'
    - require:
      - file: /etc/backup.secret
      - file: /mnt/backup

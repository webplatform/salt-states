{%- set deploymentBackupMountpoint = '/mnt/backup' -%}
include:
  - backup
  - rsync.secret
  - cron

backup_location:
  file.directory:
    - name: {{ deploymentBackupMountpoint }}

#backup_mount:
#  mount.mounted:
#    - name: {{ deploymentBackupMountpoint }}
#    - device: /dev/backup1/lvbackup1
#    - fstype: xfs
#    - mkmnt: True
#    - opts:
#      - defaults
#
# Take LVM snapshots of the backup directory
#backup_lvm_snapshot:
#  cron.present:
#    - user: root
#    - minute: 1
#    - hour: 4
#    - name: 'lvcreate -L2G -s -n backup-snap`date "+%-d"` /dev/backup1/lvbackup1'
#
# Only keep snapshots for the last 4 days
#remove_old_snapshots:
#  cron.present:
#    - user: root
#    - minute: 1
#    - hour: 5
#    - name: '[ -f /dev/backup1/backup-snap`date --date="4 days ago" "+%-d"` ] && lvremove -f /dev/backup1/backup-snap`date --date="4 days ago" "+%-d"`'

# @salt-master-dest
backup-salt-master:
  cron.present:
    - identifier: backup-salt-master
    - user: root
    - minute: 1
    - hour: 2
    - name: 'rsync -a --no-perms --password-file=/etc/backup.secret backup@salt::backup/ {{ deploymentBackupMountpoint }}/'
    - require:
      - file: /etc/backup.secret
      - file: {{ deploymentBackupMountpoint }}

rsync-masterdb-backup:
  cron.present:
    - identifier: rsync-masterdb-backup
    - user: root
    - minute: 1
    - hour: 2
    - name: 'rsync -a --no-perms --password-file=/etc/backup.secret backup@masterdb::backup/ {{ deploymentBackupMountpoint }}/'
    - require:
      - file: /etc/backup.secret
      - file: {{ deploymentBackupMountpoint }}

/mnt/backup:
  file.directory:
    - user: root
    - group: root
    - mode: 750

clean-backup-dir-cron:
  cron.present:
    - identifier: clean-backup-dir
    - user: root
    - minute: 1
    - hour: 2
    - name: find /mnt/backup -type f -mtime +{{ pillar['backup_days'] }} -exec rm {} \;
    - require:
      - file: /mnt/backup

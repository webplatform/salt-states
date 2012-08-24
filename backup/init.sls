/mnt/backup:
  file.directory:
    - user: root
    - group: root
    - mode: 750

clean_backup:
  cron.present:
    - user: root
    - minute: 1
    - hour: 2
    - name: find /mnt/backup -mtime +{{ pillar['backup_days'] }} -exec rm {} \;
    - require:
      - file: /mnt/backup

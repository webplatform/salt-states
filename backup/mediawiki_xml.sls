include:
  - backup

backupxml:
  cron.present:
    - user: root
    - minute: 1
    - hour: 1
    - name: "(cd /srv/salt/code/docs/current; php maintenance/dumpBackup.php --full --uploads | nice -n 19 gzip -9 > /mnt/backup/wiki-wpwiki-$(date '+%Y%m%d').xml.gz)"
    - require:
      - file: /mnt/backup

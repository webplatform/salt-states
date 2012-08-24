backupsalt:
  cron.present:
    - user: root
    - minute: 30
    - hour: 1
    - name: "tar -czvf /mnt/backup/salt-master-$(date '+%Y%m%d').tar.gz /srv/pillar /srv/runner /srv/salt"
    - require:
      - file: /mnt/backup

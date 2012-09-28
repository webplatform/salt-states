/usr/local/sbin/salt_master.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 555
    - source: salt://backup/salt_master.sh

backupsalt:
  cron.present:
    - user: root
    - minute: 30
    - hour: 1
    - name: "/usr/local/sbin/salt_master.sh"
    - require:
      - file: /mnt/backup

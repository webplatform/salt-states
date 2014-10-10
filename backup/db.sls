include:
  - backup

/usr/local/sbin/db.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 555
    - source: salt://backup/db.sh

create-database-backup:
  cron.present:
    - identifier: create-database-backup
    - user: root
    - minute: 1
    - hour: 1
    - name: "JOBNAME=master-backup cronhelper.sh /usr/local/sbin/db.sh"
    - require:
      - file: /mnt/backup
      - file: /usr/local/sbin/db.sh

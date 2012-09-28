include:
  - backup

/usr/local/sbin/mediawiki_db.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 555
    - source: salt://backup/mediawiki_db.sh

backupdb:
  cron.present:
    - user: root
    - minute: 1
    - hour: 1
    - name: "/usr/local/sbin/mediawiki_db.sh"
    - require:
      - file: /mnt/backup
      - file: /usr/local/sbin/mediawiki_db.sh

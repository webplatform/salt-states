include:
  - backup

/usr/local/sbin/mediawiki_xml.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 555
    - source: salt://backup/mediawiki_xml.sh

backupxml:
  cron.present:
    - identifier: mediawiki-backup-xml
    - user: root
    - minute: 1
    - hour: 1
    - name: "/usr/local/sbin/mediawiki_xml.sh"
    - require:
      - file: /mnt/backup
      - file: /usr/local/sbin/mediawiki_xml.sh

/srv/mediawiki_images:
  mount.mounted:
    - device: storage1.dho.wpdn:/wiki-images
    - fstype: glusterfs
    - mkmnt: True
    - opts:
      - defaults
      - _netdev=eth0
      - log-level=WARNING
      - log-file=/var/log/gluster.log
    - require:
      - pkg: glusterfs-client

/usr/local/sbin/mediawiki_images.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 555
    - source: salt://backup/mediawiki_images.sh

backupimages:
  cron.present:
    - identifier: backup-mediawiki-images
    - user: root
    - minute: 30
    - hour: 1
    - name: "/usr/local/sbin/mediawiki_images.sh"
    - require:
      - file: /mnt/backup
      - file: /usr/local/sbin/mediawiki_images.sh
      - mount: /srv/mediawiki_images

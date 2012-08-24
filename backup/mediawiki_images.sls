/srv/mediawiki_images:
  mount.mounted:
    - device: 10.5.152.98:/images
    - fstype: glusterfs
    - mkmnt: True
    - opts:
      - defaults
      - _netdev=eth0
      - log-level=WARNING
      - log-file=/var/log/gluster.log
    - require:
      - pkg: glusterfs-client

backupimages:
  cron.present:
    - user: root
    - minute: 30
    - hour: 1
    - name: "tar -czvf /mnt/backup/wiki-wpwiki-$(date '+%Y%m%d')-images.tar.gz /srv/mediawiki_images"
    - require:
      - file: /mnt/backup
      - mount: /srv/mediawiki_images

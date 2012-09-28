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

/usr/local/sbin/mediawiki_images.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 555
    - source: salt://backup/mediawiki_images.sh

backupimages:
  cron.present:
    - user: root
    - minute: 30
    - hour: 1
    - name: "/usr/local/sbin/mediawiki_images.sh"
    - require:
      - file: /mnt/backup
      - file: /usr/local/sbin/mediawiki_images.sh
      - mount: /srv/mediawiki_images

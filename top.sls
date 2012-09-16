base:
  '*':
    - dhcp
    - dns
    - git
    - groups
    - hosts
    - network
    - mail
    - mercurial
    - subversion
    - sudo
    - users
  'app*':
    - apache.webplatform
    - apache.docs
    - apache.talk
    - glusterfs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - memcached
    - qwebirc
    - qwebirc.daemon
  'backup*':
    - backup
    - backup.master
  'db*':
    - backup.mediawiki_db
    - mysql.server
    - rsync
  'deployment*':
    - backup.mediawiki_xml
    - backup.mediawiki_images
    - backup.salt_master
    - glusterfs
    - mediawiki
    - qwebirc
    - rsync
    - environment
  'storage*':
    - glusterfs
    - glusterfs.server
    - glusterfs.images_volume
    - xfs

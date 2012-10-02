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
    - syslog
    - lvm
    - xfs
    - monitor
  'app*':
    - apache.webplatform
    - apache.docs
    - apache.talk
    - apache.stats
    - apache.blog
    - apache.www
    - glusterfs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - memcached
    - qwebirc
    - qwebirc.daemon
    - piwik
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
    - syslog.syslog_ng
  'storage*':
    - glusterfs
    - glusterfs.server
    - glusterfs.images_volume
    - glusterfs.appstorage
  'monitor*':
    - monitor.gmetad
    - monitor.web
    - apache

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
    - ntp
    - subversion
    - sudo
    - users
    - logging
    - lvm
    - xfs
    - monitor
  'app*':
    - apache.webplatform
    - apache.docs
    - apache.talk
    - apache.stats
    - apache.blog
    - apache.dabblet
    - glusterfs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - mediawiki.jobrunner
    - qwebirc
    - qwebirc.daemon
    - piwik
  'backup*':
    - backup
    - backup.master
  'bots*':
    - bots
  'code*':
    - gerrit
  'db*':
    - backup.db
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
    - logging.syslog_ng
    - logging.udp2log
    - python
    - python.mysqldb
  'storage*':
    - glusterfs
    - glusterfs.server
    - glusterfs.images_volume
    - glusterfs.appstorage
  'memcache*':
    - memcached
  'monitor*':
    - monitor.gmetad
    - monitor.web
    - apache
    - apache.ganglia
  'project*':
    - apache
    - apache.buggenie
  'kuma.webplatform.org':
    - apache
    - apache.kuma
    - kuma
  'challenge*':
    - users.renoirb

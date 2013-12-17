base:
  '*':
    - webplatform
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
    - cron
  'app*':
    - php
    - apache.webplatform
    - apache.docs
    - apache.talk
    - apache.dabblet
    - glusterfs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
#    - qwebirc
#    - qwebirc.daemon
    - mediawiki.jobrunner
  'app-hypotesis*':
    - hypotesis
  'backup*':
    - backup
    - backup.master
  'blog*':
    - php
    - wordpress
    - apache.blog
  'bots*':
    - bots
  'code*':
    - apache.gerrit
    - gerrit
    - rsync
  'db*':
    - backup.db
    - mysql.server
    - mysql.ssl
    - rsync
  'db4*':
    - specific.master-db
  'deployment*':
    - environment.deploy
    - halite
    - backup.mediawiki_xml
#    - backup.mediawiki_images
    - backup.salt_master
    - logrotate
    - logrotate.deployment
    - glusterfs
#    - qwebirc
    - rsync
    - specific.deployment
    - logging.syslog_ng
    - logging.udp2log
    - python
    - python.mysqldb
  'storage*':
    - glusterfs
    - glusterfs.server
    - glusterfs.images_volume
    - glusterfs.appstorage
  'storage1*':
    - specific.storage1
  'memcache*':
    - memcached
  'monitor*':
    - monitor.gmetad
    - monitor.web
    - apache.ganglia
  'project*':
    - php
    - apache.buggenie
    - buggenie.crontab
  'kuma.webplatform.org':
    - apache.kuma
    - kuma
  'piwik*':
    - php
    - piwik
    - piwik.archive

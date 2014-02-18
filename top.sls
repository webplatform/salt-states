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
    - webplatform.swift-dreamobjects
  'app5':
    - mediawiki.jobrunner
  'app-hypotesis*':
    - hypotesis
  'backup*':
    - backup
    - backup.master
    - webplatform.swift-dreamobjects
  'blog*':
    - php
    - wordpress
    - apache.blog
    - apache.web25
    - webplatform.swift-dreamobjects
  'bots*':
    - bots
  'code*':
    - apache.gerrit
    - gerrit
    - rsync
    - webplatform.swift-dreamobjects
  'db*':
    - logwatch
    - mysql.server
    - mysql.ssl
    - rsync
  'db4*':
    - specific.master-db
  'deployment*':
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
    - webplatform.swift-dreamobjects
  'storage*':
    - glusterfs
    - glusterfs.server
    - glusterfs.images_volume
    - glusterfs.appstorage
    - webplatform.swift-dreamobjects
  'storage1*':
    - specific.storage1
  'memcache*':
    - memcached
  'monitor*':
    - monitor.gmetad
    - monitor.web
    - apache.ganglia
  'monitor':
    - specific.monitor
  'project*':
    - php
    - apache.buggenie
    - buggenie.mailqueue
    - webplatform.swift-dreamobjects
  'kuma.webplatform.org':
    - apache.kuma
    - kuma
  'piwik*':
    - php
    - piwik
    - piwik.archive
  'mail*':
    - logwatch
    - mail.mailhub

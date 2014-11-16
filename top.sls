#vim: ai ft=yaml
base:
  '*':
    - code.packages
    - salt
    - mmonit
    - etcd
    - users
    - groups
    - sudo
    - webplatform
    - mail
    - git
    - mercurial
    - subversion
    - cron
    - ntp
    - network
    - lvm
    - xfs
    - sysctl
#    - dhcp
#    - logging
#    - monitor
    - hosts
  'salt*':
    - salt.master
    - specific.salt
    - logrotate.remote-logs
    - mysql
    - php.composer
    - dns.server
    - rsync
    - python
    - python.mysqldb
    - webplatform.swift-dreamobjects
#    - backup.salt_master
#    - logging.syslog_ng
#    - logging.udp2log
#    - glusterfs
#    - halite
#    - backup.mediawiki_xml
  'app*':
    - php
    - nutcracker
    - bots.lumberjack-web
    - apache.webplatform_ssl
    - apache.webplatform_com
    - apache.webplatform
    - apache.docs
    - apache.dabblet
    - apache.status
    - apache.specs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - webplatform.swift-dreamobjects
    - logrotate.mediawiki-debug
  'app3':
    - mediawiki.jobrunner
  'backup*':
    - backup.master
    - webplatform.swift-dreamobjects
  'blog*':
    - php
    - nutcracker
    - wordpress
    - apache.blog
    - apache.status
    - webplatform.swift-dreamobjects
  'bots':
    - bots.lumberjack-listener
  'code*':
    - gerrit
    - rsync
    - webplatform.swift-dreamobjects
  'db*':
    - logwatch
    - mysql.server
    - rsync
  'db1':
    - specific.master-db
  'postgres*':
    - postgres
    - rsync
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
  'redis*':
    - redis
  'redis-jobs1':
    - redis.live
  'monitor*':
    - monitor.gmetad
    - monitor.web
    - apache.ganglia
    - apache.status
  'monitor':
    - specific.monitor
  'project*':
    - php
    - php.apache
    - nutcracker
    - buggenie
    - apache.project
    - apache.status
    - buggenie.mailqueue
    - webplatform.swift-dreamobjects
  'piwik*':
    - piwik
    - nutcracker
  'mail*':
    - logwatch
    - mail.mailhub
  'notes*':
    - hypothesis
    - users.randall
  'elastic*':
    - elasticsearch
  'webat25*':
    - specific.webat25
    - apache.status
  'builder*':
    - specific.builder
  'accounts*':
    - fxa
  'hhvmbackend*':
    - hhvm
    - nutcracker

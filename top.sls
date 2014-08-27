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
    - apache.status
#    - glusterfs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - webplatform.swift-dreamobjects
  'app9':
    - mediawiki.jobrunner
  'backup*':
    - backup
    - backup.master
    - webplatform.swift-dreamobjects
  'blog*':
    - php
    - wordpress
    - apache.blog
    - apache.status
    - webplatform.swift-dreamobjects
  'bots*':
    - bots
  'code*':
    - apache.gerrit
    - gerrit
    - rsync
    - webplatform.swift-dreamobjects
#  'db*':
#    - logwatch
#    - mysql.server
#    - mysql.ssl
#    - rsync
#  'db4*':
#    - specific.master-db
  'percona*':
    - percona.cluster
    - mysql.ssl
  'deployment*':
    - halite
    - backup.mediawiki_xml
#    - backup.mediawiki_images
    - backup.salt_master
    - logrotate
    - logrotate.deployment
    - glusterfs
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
    - apache.status
  'monitor':
    - specific.monitor
  'project*':
    - php
    - apache.buggenie
    - apache.status
    - buggenie.mailqueue
    - webplatform.swift-dreamobjects
  'kuma.webplatform.org':
    - apache.kuma
    - kuma
  'piwik*':
    - piwik
  'mail*':
    - logwatch
    - mail.mailhub
  'notes*':
    - hypothesis
    - users.randall
  'app-hypothesis':
    - specific.sandbox
  'elastic*':
    - elasticsearch
  'webat25*':
    - specific.webat25
    - apache.status
#  'ssl*':
#    - sslproxy.nginx
#    - nodejs
  'sandbox*':
    - percona.cluster
    - mediawiki.scaler
    - apache.docs
    - specific.sandbox
  'builder*':
    - specific.builder
  'accounts*':
    - fxa

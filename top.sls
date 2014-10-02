base:
  '*':
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
#    - dhcp
#    - logging
#    - monitor
    - hosts
  'salt*':
    - dns.server
    - logrotate
    - logrotate.deployment
    - rsync
    - specific.deployment
    - python
    - python.mysqldb
    - webplatform.swift-dreamobjects
#    - halite
#    - backup.mediawiki_xml
#    - backup.salt_master
#    - glusterfs
#    - logging.syslog_ng
#    - logging.udp2log
  'app*':
    - php
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
    - gerrit
    - rsync
    - webplatform.swift-dreamobjects
  'db*':
    - logwatch
    - mysql.server
    - rsync
#  'db4*':
#    - specific.master-db
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
    - apache.project
    - apache.status
    - buggenie.mailqueue
    - webplatform.swift-dreamobjects
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

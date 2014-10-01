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
#    - dns
#    - logging
#    - monitor
    - hosts
  'salt*':
#    - halite
#    - backup.mediawiki_xml
#    - backup.salt_master
    - logrotate
    - logrotate.deployment
#    - glusterfs
    - rsync
    - specific.deployment
#    - logging.syslog_ng
#    - logging.udp2log
    - python
    - python.mysqldb
    - webplatform.swift-dreamobjects
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

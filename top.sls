#vim: ai ft=yaml
#
# Ref:
#   - http://docs.saltstack.com/en/latest/ref/states/top.html#other-ways-of-targeting-minions
#
base:
  '*':
    - salt
    - mmonit
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
    - logrotate.mediawiki-debug
  'backup*':
    - backup.master
  'blog*':
    - php
    - nutcracker
    - wordpress
    - apache.blog
    - apache.status
  'bots':
    - bots.lumberjack-listener
  'code*':
    - gerrit
    - rsync
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
  'storage1*':
    - specific.storage1
  'memcache*':
    - memcached
  'monitor*':
    - monitor.gmetad
    - monitor.web
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
  'accounts*':
    - fxa
  'hhvmbackend*':
    - hhvm
    - nutcracker

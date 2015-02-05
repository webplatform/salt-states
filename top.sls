#vim: ai ft=yaml
#
# Ref:
#   - http://docs.saltstack.com/en/latest/ref/states/top.html#other-ways-of-targeting-minions
#
base:
  '*':
    - salt
    - mmonit
    - logrotate
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
    - logging
#    - monitor
    - hosts
  'salt*':
    - salt.master
    - specific.salt
    - logrotate.remote-logs
    - mysql
    - php.composer
    - gdnsd
    - rsync
    - python
    - python.mysqldb
    - webplatform.swift-dreamobjects
#    - backup.salt_master
    - logging.syslog_ng
    - logging.udp2log
#    - backup.mediawiki_xml
  'app*':
    - php
    - nutcracker
    - apache.webplatform_ssl
    - apache.webplatform_com
    - apache.webplatform
    - apache.docs
    - apache.dabblet
    - apache.status
    - apache.specs
    - apache.webat25
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
  'bots*':
    - bots
  'code*':
    - gerrit
    - rsync
  'db*':
    - logwatch
    - mysql.server
    - rsync
  'postgres*':
    - postgres
    - rsync
  'memcache*':
    - memcached
  'redis*':
    - redis.server
  'session*':
    - memcached
    - redis.server
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
    - piwik.nginx
    - php-fpm
    - piwik
    - nutcracker
  'mail*':
    - logwatch
    - mail.mailhub
  'notes*':
    - hypothesis
    - hypothesis.nginx
  'elastic*':
    - elasticsearch
  'accounts*':
    - fxa
  'hhvmbackend*':
    - hhvm
    - nutcracker
  'nginx*':
    - nginx
  'roles:specs':
    - match: grain
    - specs.nginx



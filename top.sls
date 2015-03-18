#vim: ai ft=yaml
#
# Ref:
#   - http://docs.saltstack.com/en/latest/ref/states/top.html#other-ways-of-targeting-minions
#
base:
  '*':
    - salt
    - mmonit
    - logrotate.jobs
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
    - mysql
    - php.composer
    - gdnsd
    - rsync
    - python
    - python.mysqldb
    - webplatform.swift-dreamobjects
#    - backup.salt_master
#    - backup.mediawiki_xml
    - logging.syslog_ng
    - logging.udp2log
    - logging.remote-logs
  'app*':
    - php
    - nutcracker
    - apache.webplatform_ssl
    - apache.webplatform_com
    - apache.webplatform
    - apache.docs
    - apache.dabblet
    - apache.status
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - mediawiki.logrotate
  'backup*':
    - backup.master
    - backup.nfs
    - backup.elasticsearch
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
    - formula.redis
  'session*':
    - memcached
    - redis.server
    - formula.redis
  'monitor*':
#    - monitor.gmetad
#    - monitor.web
    - monitor.logstash_receptacle
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
    - users.app-user
    - php-fpm
    - piwik
    - nutcracker
  'mail*':
    - logwatch
    - mail.mailhub
  'elastic*':
    - elasticsearch
  'hhvmbackend*':
    - hhvm
    - nutcracker
  'roles:nginx':
    - match: grain
    - users.app-user
    - nginx
    - fxa.nginx
    - hypothesis.nginx
    - specs.nginx
    - piwik.nginx
  'roles:specs':
    - match: grain
    - specs
  'roles:notes':
    - match: grain
    - hypothesis
    - hypothesis.fxa_and_h_ssl_issue
  'roles:accounts':
    - match: grain
    - fxa
    - fxa.fxa_and_h_ssl_issue


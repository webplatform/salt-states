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
  'roles:stats':
    - match: grain
    - users.app-user
    - php-fpm
    - piwik.local
    - nutcracker
  'mail*':
    - logwatch
    - mail.mailhub
  'roles:elastic':
    - match: grain
    - elasticsearch.main_cluster
  'roles:jobrunner':
    - match: grain
    - elasticsearch.wiki_cluster
  'hhvmbackend*':
    - hhvm
    - nutcracker
  'roles:specs':
    - match: grain
    - specs.local
  'roles:notes':
    - match: grain
    - hypothesis.local
  'roles:auth':
    - match: grain
    - fxa.local
  'roles:builder':
    - match: grain
    - builder
    - nodejs
  'roles:docker':
    - match: grain
    - webplatform.docker
  'roles:frontend':
    - match: grain
    - users.app-user
    - fxa.nginx
    - hypothesis.nginx
    - specs.nginx
    - piwik.nginx
    - monitor.nginx
    - discuss.nginx

# vim: ai filetype=yaml tabstop=2 softtabstop=2 shiftwidth=2


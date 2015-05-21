base:
  '*':
    - basesystem
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
    - webplatform.dreamobjects
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
    - webplatform.dreamobjects
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
  'roles:db':
    - match: grain
    - logwatch
    - mysql.server
    - rsync
  'roles:postgres':
    - match: grain
    - webplatform.postgres
    - postgres
    - logwatch
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
    - webplatform.docker
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
  'roles:noc':
    - match: grain
    - webplatform.docker
  'roles:jobrunner':
    - match: grain
    - elasticsearch.wiki_cluster
  'hhvmbackend*':
    - hhvm
    - nutcracker
  'roles:discuss':
    - match: grain
    - webplatform.docker
    - webplatform.dreamobjects
    - discourse.local
  'roles:specs':
    - match: grain
    - specs.local
    - webplatform.docker
    - webplatform.dreamobjects
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
    - webplatform.dreamobjects
  'roles:masterdb':
    - match: grain
    - webplatform.dreamobjects
  'roles:frontend':
    - match: grain
    - fxa.frontend
    - hypothesis.frontend
    - specs.frontend
    - piwik.frontend
    - monitor.frontend
    - discourse.frontend
    - etherpad.frontend
    - webat25.frontend
  'roles:webat:':
    - match: grain
    - webat25.deprecate_me_soon

# vim: ai filetype=yaml tabstop=2 softtabstop=2 shiftwidth=2


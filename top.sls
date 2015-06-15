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
    - logging
#    - monitor
    - hosts

  # OpenStack/DreamCompute AND salt only
  'salt* and G@virtual:kvm':
    - match: compound
    - gdnsd

  # salt AND Vagrant only
  'salt* and G@biosversion:VirtualBox':
    - match: compound
    - workbench.salt

  # Vagrant only
  'biosversion:VirtualBox':
    - match: grain
    - workbench

  'salt*':
    - salt.master
    - mysql
    - php.composer
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
    - webplatform.formulas.postgres
    - postgres
    - logwatch
    - rsync
  'memcache*':
    - memcached
  'redis*':
    - webplatform.formulas.redis
    - redis.server
  'session*':
    - webplatform.formulas.redis
    - redis.server
    - memcached
  'monitor*':
#    - monitor.gmetad
#    - monitor.web
    - webplatform.formulas.docker
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
  'roles:discuss':
    - match: grain
    - webplatform.formulas.docker
    - webplatform.dreamobjects
    - discourse.local
  'roles:specs':
    - match: grain
    - specs.local
    - webplatform.formulas.docker
    - webplatform.dreamobjects
  'roles:notes':
    - match: grain
    - hypothesis.local
  'roles:auth':
    - match: grain
    - fxa.local
  'roles:docker':
    - match: grain
    - webplatform.formulas.docker
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


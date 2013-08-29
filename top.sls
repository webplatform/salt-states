base:
  '*':
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
    - apache.webplatform
    - apache.docs
    - apache.talk
    - apache.dabblet
    - glusterfs
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - qwebirc
    - qwebirc.daemon
    - mediawiki.jobrunner
  'backup*':
    - backup
    - backup.master
  'blog*':
    - wordpress
    - apache.blog
  'bots*':
    - bots
  'code*':
    - gerrit
  'db*':
    - backup.db
    - mysql.server
    - rsync
  'deployment*':
    - backup.mediawiki_xml
    - backup.mediawiki_images
    - backup.salt_master
    - glusterfs
    - mediawiki
    - qwebirc
    - rsync
    - environment
    - logging.syslog_ng
    - logging.udp2log
    - python
    - python.mysqldb
  'storage*':
    - glusterfs
    - glusterfs.server
    - glusterfs.images_volume
    - glusterfs.appstorage
  'memcache*':
    - memcached
  'monitor*':
    - monitor.gmetad
    - monitor.web
    - apache
    - apache.ganglia
  'project*':
    - apache
    - apache.buggenie
    - buggenie.crontab
  'kuma.webplatform.org':
    - apache
    - apache.kuma
    - kuma
  'challenge*':
    - users.renoirb
  'piwik0*':
    - apache
    - piwik
    - apache.stats
    - php.apache
    - apache.disabled
  'piwik[1-2]*':
    - nginx
    - php.fpm
    - piwik


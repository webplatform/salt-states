base:
  '*':
    - users
    - groups
    - sudo
    - git
    - network
    - dhcp
    - dns
    - mail
    - mercurial
    - subversion
  'app*':
    - mediawiki
    - mediawiki.appserver
    - mediawiki.scaler
    - memcached
    - apache.webplatform
    - qwebirc
    - qwebirc.daemon
    - glusterfs
  'db*':
    - mysql.server
  'deployment*':
    - mediawiki
    - rsyncd
    - qwebirc
  'storage*':
    - glusterfs
    - glusterfs.server
    - xfs

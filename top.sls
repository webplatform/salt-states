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
  'db*':
    - mysql.server
  'deployment*':
    - mediawiki
    - rsyncd
    - qwebirc

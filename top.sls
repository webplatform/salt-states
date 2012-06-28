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
  'app*':
    - mediawiki
    - mediawiki.scaler
    - memcached
    - apache.webplatform
  'db*':
    - mysql.server

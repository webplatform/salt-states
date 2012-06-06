base:
  '*':
    - users
    - groups
    - sudo
    - git
    - network
    - dhcp
    - dns
  'app*':
    - mediawiki
    - mediawiki.scaler
    - memcached
    - apache.webplatform
  'db*':
    - mysql.server

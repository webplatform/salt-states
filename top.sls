base:
  '*':
    - users
    - groups
    - sudo
    - git
    - dhcp
    - dns
  'app*':
    - mediawiki
    - mediawiki.scaler
    - memcached
    - apache.webplatform
  'db*':
    - mysql.server

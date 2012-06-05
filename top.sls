base:
  '*':
    - users
    - groups
    - sudo
    - git
  'app*':
    - mediawiki
    - mediawiki.scaler
    - memcached
    - apache.webplatform
  'db*':
    - mysql.server

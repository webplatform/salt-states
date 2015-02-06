include:
  - redis.server

/etc/redis/redis.conf:
  file.comment:
    - regex: ^tcp-backlog 511


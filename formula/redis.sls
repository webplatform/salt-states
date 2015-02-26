include:
  - redis.server
  - mmonit

/etc/redis/redis.conf:
  file.comment:
    - regex: ^tcp-backlog 511

/etc/monit/conf.d/redis-server.conf:
  file.managed:
    - contents: |
        # Managed by Salt Stack
        check process redis-server
          with pidfile "{{ salt['pillar.get']('redis:pidfile') }}"
          group keystore
          start = "/usr/sbin/service redis-server start"
          stop  = "/usr/sbin/service redis-server stop"
          if failed host {{ salt['grains.get']('ipaddr', '127.0.0.1') }} port 6379 then restart
          if not exist for 3 cycles then restart
          if 3 restarts within 5 cycles then alert
          if 5 restarts within 5 cycles then timeout

# Make sure file salt/files/gitfs.conf has https://github.com/webplatform/redis-formula.git
# and that /etc/salt/master.d/gitfs.conf has a reference to it. @TODO


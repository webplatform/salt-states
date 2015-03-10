#
# Remote logs receptacle, logs rotation states
#
# Dependencies with `gitfs_remotes`, check in salt/files/gitfs.conf for the following:
#
#   - logrotate:
#     href: https://github.com/webplatform/logrotate-formula
#
include:
  - logrotate

/etc/logrotate.d/remote-logs:
  file.managed:
    - source: salt://logging/files/logrotate.remote-logs
    - mode: 644
    - require:
      - pkg: logrotate


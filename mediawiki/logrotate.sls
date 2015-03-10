#
# MediaWiki logs rotation
#
# Dependencies with `gitfs_remotes`, check in salt/files/gitfs.conf for the following:
#
#   - logrotate:
#     href: https://github.com/webplatform/logrotate-formula
#
include:
  - logrotate

/etc/logrotate.d/mediawiki-debug:
  file.managed:
    - source: salt://mediawiki/files/logrotate.mediawiki-debug
    - mode: 644
    - require:
      - pkg: logrotate


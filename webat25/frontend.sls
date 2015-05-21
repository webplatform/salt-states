include:
  - nginx

#
# This is the PUBLIC virtual host for **webat25.org** serving static files.
#
# At this time, we copy on frontend node the static files, but that should change. #TODO
# ref: https://github.com/webplatform/ops/issues/169
#
# ===========================================================================
#

/etc/nginx/sites-available/webat25:
  file.managed:
    - source: salt://webat25/files/nginx.frontend.conf.jinja
    - template: jinja
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-webat25:
  file.symlink:
    - target: /etc/nginx/sites-available/webat25


#
# After a few days of debugging, on a problem with the annotation-server and Python and SSL certificates
# this should make accounts server to have no other NGINX vhost except the private ones.
#
extend:
  /etc/nginx/sites-enabled/00-default:
    file:
      - absent
  /etc/nginx/sites-enabled/10-notes:
    file:
      - absent
  /etc/nginx/sites-enabled/10-specs:
    file:
      - absent
  /etc/nginx/sites-enabled/10-accounts:
    file:
      - absent

/etc/nginx/sites-enabled/default:
  file.absent


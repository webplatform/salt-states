fxa-nginx-deps:
  pkg.installed:
    - names:
      - nginx-full
      - nginx-extras

/etc/nginx/sites-enabled/default:
  file:
    - absent

include:
  - nginx
  - nginx.status

/var/www/index.html:
  file.managed:
    - source: salt://nginx/files/index.html

extend:
  /etc/nginx/sites-available/default:
    file.managed:
      - contents: |
          # Managed by Salt Stack. Do NOT edit manually!


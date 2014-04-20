include:
  - hypothesis

nginx:
  pkg:
    - latest
  service:
    - running
    - watch:
      - file: nginxconf
  pkgrepo.managed:
    - ppa: nginx/stable
    - require_in:
      - pkg: nginx

nginxconf:
  file.managed:
    - name: /etc/nginx/sites-enabled/notes
    - source: salt://hypothesis/files/nginx.notes.jinja
    - template: jinja

/etc/nginx/sites-enabled/default:
  file:
    - absent

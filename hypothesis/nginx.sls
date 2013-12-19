include:
  - hypothesis

nginx:
  pkg:
    - latest
  service:
    - running
    - watch:
      - file: nginxconf

nginxconf:
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://hypothesis/files/nginx.default.jinja
    - template: jinja
    - makedirs: True
    - mode: 755

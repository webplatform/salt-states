include:
  - sslproxy
  - ssl

nginx:
  pkg:
    - latest
  pkgrepo.managed:
    - ppa: nginx/stable
    - require_in:
      - pkg: nginx
  service:
    - running
    - watch:
      - file: nginxconf

nginxconf:
  file.managed:
    - name: /etc/nginx/sites-enabled/ssl
    - source: salt://sslproxy/files/nginx.vhost.jinja
    - template: jinja
    - makedirs: True
    - mode: 755
    - require:
      - file: /etc/ssl/webplatform/webplatform.key
      - file: /etc/ssl/webplatform/webplatform.pem

/etc/nginx/sites-enabled/default:
  file:
    - absent

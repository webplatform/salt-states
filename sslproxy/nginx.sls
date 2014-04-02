include:
  - sslproxy

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
#      - file: /etc/ssl/webplatform/webplatform.pem

webplatform-ssl-pem:
  cmd:
    - run
    - name: files=("webplatform.crt" "startssl.sub.class1.server.ca.pem" "startssl.ca.pem") && for i in ${files[@]} ; do $(cat $i >> webplatform.pem && echo "" >> webplatform.pem) ; done
    - unless: test -f /etc/ssl/webplatform/webplatform.pem
    - cwd: /etc/ssl/webplatform/
    - require:
      - file: /etc/ssl/webplatform/webplatform.crt
      - file: /etc/ssl/webplatform/startssl.ca.pem
      - file: /etc/ssl/webplatform/startssl.sub.class1.server.ca.pem

nginxconf:
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://sslproxy/files/nginx.default.jinja
    - template: jinja
    - makedirs: True
    - mode: 755
    - require:
      - file: /etc/ssl/webplatform/webplatform.crt
      - file: /etc/ssl/webplatform/webplatform.key
      - file: /etc/ssl/webplatform/startssl.ca.pem
      - file: /etc/ssl/webplatform/startssl.sub.class1.server.ca.pem
#      - file: /etc/ssl/webplatform/webplatform.pem
#
# #TODO:
#  - Concatenate files into webplatform.pem
#  - Make sure webplatform.key is 640
#
#/etc/ssl/webplatform/webplatform.pem:
#  cmd.run:
#    - cwd: /etc/ssl/webplatform/
#    - unless: /etc/ssl/webplatform/webplatform.pem
#    - names:
#      - cat webplatform.crt > webplatform.pem
#      - cat startssl.sub.class1.server.ca.pem >> webplatform.pem
#      - cat startssl.ca.pem >> webplatform.pem

include:
  - mysql.server

##
## Sync SSL certificates across VMs
##
## Reference
##  - http://bridge.grumpy-troll.org/2013/04/mysql-ssltls-and-ubuntu.html
##  - https://mifosforge.jira.com/wiki/display/MIFOS/How+to+enable+MySQL+SSL+on+Ubuntu
##  - http://dev.mysql.com/doc/refman/5.1/en/creating-ssl-certs.html
##
## Creating a certificate:
##  - openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem
##  - openssl rsa -in server-key.pem -out server-key.pem
##  - openssl x509 -req -in server-req.pem -days 3600 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem
##
## Improvement roadmap:
##   - Move what is related to a SSL certificate, not only MySQL would benefit from what is here
##   - Use salt to generated based on a CA cert generated when created current salt master, then use to generate self-signed certs
##

openssl-installed:
  pkg.installed:
    - name: openssl

openssl-client-newkey:
  cmd.run:
    - stateful: True
    - cwd: /etc/mysql
    - unless: test -s /etc/mysql/client-req.pem
    - name: /usr/bin/openssl req -newkey rsa:2048 -days 3600 -nodes -keyout client-key.pem -out client-req.pem -subj '/C=US/ST=MA/L=Cambridge/O=W3C/OU=WebPlatform Docs/CN={{ grains['host'] }}/emailAddress=team-webplatform-systems@w3.org'
    - require:
      - pkg: openssl-installed
      - pkg: db-server
  file.managed:
    - name: /etc/mysql/client-req.pem
    - user: mysql
    - group: ops
    - mode: 640
    - require:
      - pkg: db-server

openssl-client-key:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl rsa -in client-key.pem -out client-key.pem'
    - cwd: /etc/mysql
    - require:
      - cmd: openssl-client-newkey
      - pkg: db-server
  file.managed:
    - name: /etc/mysql/client-key.pem
    - user: mysql
    - group: ops
    - mode: 640
    - require:
      - pkg: db-server

openssl-client-cert:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl x509 -req -in client-req.pem -days 3600 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem'
    - cwd: /etc/mysql
    - unless: test -s /etc/mysql/client-cert.pem
    - require:
      - cmd: openssl-client-newkey
      - file: /etc/mysql/ca-cert.pem
      - file: /etc/mysql/ca-key.pem
      - pkg: db-server
  file.managed:
    - name: /etc/mysql/client-cert.pem
    - user: mysql
    - group: ops
    - mode: 640
    - require:
      - pkg: db-server

openssl-newkey:
  cmd.run:
    - stateful: True
    - cwd: /etc/mysql
    - unless: test -s /etc/mysql/server-req.pem
    - name: /usr/bin/openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem -subj '/C=US/ST=MA/L=Cambridge/O=W3C/OU=WebPlatform Docs/CN={{ grains['host'] }}/emailAddress=team-webplatform-systems@w3.org'
    - require:
      - pkg: openssl-installed
      - pkg: db-server
  file.managed:
    - name: /etc/mysql/server-req.pem
    - user: mysql
    - group: mysql
    - mode: 640
    - require:
      - pkg: db-server

openssl-key:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl rsa -in server-key.pem -out server-key.pem'
    - cwd: /etc/mysql
    - require:
      - cmd: openssl-newkey
      - pkg: db-server
  file.managed:
    - name: /etc/mysql/server-key.pem
    - user: mysql
    - group: mysql
    - mode: 640
    - require:
      - pkg: db-server

openssl-cert:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl x509 -req -in server-req.pem -days 3600 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem'
    - cwd: /etc/mysql
    - unless: test -s /etc/mysql/server-cert.pem
    - require:
      - cmd: openssl-newkey
      - file: /etc/mysql/ca-cert.pem
      - file: /etc/mysql/ca-key.pem
      - pkg: db-server
  file.managed:
    - name: /etc/mysql/server-cert.pem
    - user: mysql
    - group: mysql
    - mode: 640
    - require:
      - pkg: db-server

/etc/mysql/conf.d/ssl.cnf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://mysql/files/ssl.cnf
    - require:
      - cmd: openssl-newkey
      - pkg: db-server



##
## Soon, use instead;
##
## ```bash
##    salt -G 'roles:masterdb' tls.create_ca mysql CN='salt.production.wpdn' ST='MA' L='Cambridge' O='W3C' OU='WebPlatform Docs' emailAddress='team-webplatform-systems@w3.org’
##    salt -G 'roles:masterdb' tls.create_self_signed_cert mysql CN='db1-masterdb.production.wpdn' ST='MA' L='Cambridge' O='W3C' OU='WebPlatform Docs' emailAddress='team-webplatform-systems@w3.org'
## ```
/etc/mysql/ca-key.pem:
  file.managed:
    - user: mysql
    - group: mysql
    - mode: 640
    - contents_pillar: 'mysql:ssl:ca-key.pem'
    - require:
      - pkg: db-server

/etc/mysql/ca-cert.pem:
  file.managed:
    - user: mysql
    - group: mysql
    - mode: 640
    - contents_pillar: 'mysql:ssl:ca-cert.pem'
    - require:
      - pkg: db-server


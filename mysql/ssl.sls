include:
  - .

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
    - name: /usr/bin/openssl req -newkey rsa:2048 -days 3600 -nodes -keyout client-key.pem -out client-req.pem -subj '/C=US/ST=MA/L=Cambridge/O=W3C/OU=WebPlatform Docs/CN={{ grains["fqdn"] }}/emailAddress=team-webplatform-systems@w3.org'
    - creates: /etc/mysql/client-req.pem
    - cwd: /etc/mysql
    - mode: 640

openssl-client-key:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl rsa -in client-key.pem -out client-key.pem'
    - creates: /etc/mysql/client-key.pem
    - cwd: /etc/mysql
    - mode: 640

openssl-client-cert:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl x509 -req -in client-req.pem -days 3600 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem'
    - creates: /etc/mysql/client-cert.pem
    - cwd: /etc/mysql
    - mode: 640
    - require:
      - file: /etc/mysql/ca-cert.pem
      - file: /etc/mysql/ca-key.pem

openssl-newkey:
  cmd.run:
    - stateful: True
    - name: /usr/bin/openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem -subj '/C=US/ST=MA/L=Cambridge/O=W3C/OU=WebPlatform Docs/CN={{ grains["fqdn"] }}/emailAddress=team-webplatform-systems@w3.org'
    - cwd: /etc/mysql
    - creates: /etc/mysql/server-req.pem
    - mode: 640

openssl-key:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl rsa -in server-key.pem -out server-key.pem'
    - creates: /etc/mysql/server-key.pem
    - cwd: /etc/mysql
    - mode: 640

openssl-cert:
  cmd.run:
    - stateful: True
    - name: '/usr/bin/openssl x509 -req -in server-req.pem -days 3600 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem'
    - creates: /etc/mysql/server-cert.pem
    - cwd: /etc/mysql
    - mode: 640
    - require:
      - file: /etc/mysql/ca-cert.pem
      - file: /etc/mysql/ca-key.pem

/etc/mysql/conf.d/ssl.cnf:
  file.managed:
    - mode: 644
    - source: salt://mysql/files/ssl.cnf


##
## Soon, use instead;
##
## ```bash
##    salt -G 'roles:masterdb' tls.create_ca mysql CN='salt.production.wpdn' ST='MA' L='Cambridge' O='W3C' OU='WebPlatform Docs' emailAddress='team-webplatform-systems@w3.org’
##    salt -G 'roles:masterdb' tls.create_self_signed_cert mysql CN='db1-masterdb.production.wpdn' ST='MA' L='Cambridge' O='W3C' OU='WebPlatform Docs' emailAddress='team-webplatform-systems@w3.org'
## ```

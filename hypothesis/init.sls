#
# Reference:
#  - https://github.com/hypothesis/h/blob/develop/INSTALL.Ubuntu.rst
#
include:
  - nodejs
  - git
  - hypothesis.nginx

/var/log/webplatform:
  file:
    - directory
    - makedirs: True
    - user: renoirb
    - group: deployment

monit-checker:
  pkg:
    - installed
    - name: monit
    - require_in:
      - file: /etc/monit/conf.d/hypothesis
      - file: /srv/webplatform/h/service.sh
  file:
    - managed
    - name: /etc/monit/conf.d/hypothesis
    - template: jinja
    - source: salt://hypothesis/files/monit.conf.jinja

openjdk-7-jdk-package:
  pkg.installed:
    - names:
      - openjdk-7-jre-headless
      - openjdk-7-jdk


hypothesis-service:
  service:
    - running
    - name: hypothesis
    - enable: True
    - reload: true
    - unless: test -f /srv/webplatform/h/production.ini
    - require:
      - pkg: hypothesis-dependencies
      - file: /etc/init/hypothesis.conf
    - watch:
      - file: /srv/webplatform/h/h.ini

#/tmp/hypothesis.sock
#... make sure it has service with right user
#...

hypothesis-dependencies:
  pkg.installed:
    - names:
      - python-yaml
      - python-dev
      - python-pip
      - python-virtualenv
      - git
      - libpq-dev
      - make
      - ruby-full
      - build-essential
      - nodejs
      - npm
      - python-mysqldb

# pip install pyyaml
# gem install sass
# http://acervulus.info/2012/how-to-install-sass-on-ubuntu-precise-12-04-lts/
# gem install compass

required-gems:
  cmd.run:
    - name: gem install compass sass
    - unless: /srv/webplatform/h/h.ini
    - require:
      - pkg: ruby-full
 
# Make SURE this file exists, its required
# by the /etc/init/hypothesis.conf init script 
/srv/webplatform/h/h.ini:
  file.managed:
    - template: jinja
    - source: salt://hypothesis/files/h.ini.jinja
    - require:
      - file: /srv/webplatform/h

/srv/webplatform/h:
  file.directory:
    - makedirs: True

/etc/init/hypothesis.conf:
  file.managed:
    - source: salt://hypothesis/files/hypothesis.init
    - user: root
    - group: root
    - mode: 644
    - requires:
      - file: /srv/webplatform/h
      - file: /srv/webplatform/h/h.ini
      - file: /srv/webplatform/h/service.sh

/srv/webplatform/h/service.sh:
  file.managed:
    - source: salt://hypothesis/files/service.sh
    - require:
      - file: /srv/webplatform/h

npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
    - require:
      - pkg: npm

#
# Reference:
#  - https://github.com/hypothesis/h/blob/develop/INSTALL.Ubuntu.rst
#
include:
  - nodejs
  - git
  - hypothesis.nginx
  - mmonit

/var/log/webplatform:
  file.directory:
    - makedirs: True
    - user: renoirb
    - group: deployment

/etc/monit/conf.d/hypothesis.conf:
  file.managed:
    - template: jinja
    - source: salt://hypothesis/files/monit.conf.jinja
    - require_in:
      - file: /srv/webplatform/notes-server/service.sh
    - watch_in:
      - service: monit

hypothesis-service:
  service.running:
    - name: hypothesis
    - enable: True
    - reload: true
    - unless: test -f /srv/webplatform/notes-server/h.ini
    - require:
      - pkg: hypothesis-dependencies
      - file: /etc/init/hypothesis.conf
    - watch:
      - file: /srv/webplatform/notes-server/h.ini

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
      - rubygems-integration
  gem.installed:
    - name: sass
    - require:
      - pkg: ruby-full

# pip install pyyaml
# http://acervulus.info/2012/how-to-install-sass-on-ubuntu-precise-12-04-lts/
## Install required python dependencies via pip
#pip-dependencies:
#  cmd:
#    - run
#    - name: pip install -r /srv/webplatform/notes-server/requirements.txt

hypothesis-compass-dep:
  gem.installed:
    - name: compass
    - require:
      - pkg: ruby-full
      - gem: sass
 
# Make SURE this file exists, its required
# by the /etc/init/hypothesis.conf init script 
/srv/webplatform/notes-server/h.ini:
  file.managed:
    - template: jinja
    - source: salt://hypothesis/files/h.ini.jinja
    - require:
      - file: /srv/webplatform/notes-server

/srv/webplatform/notes-server:
  file.directory:
    - makedirs: True

/etc/init/hypothesis.conf:
  file.managed:
    - source: salt://hypothesis/files/upstart.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /srv/webplatform/notes-server
      - file: /srv/webplatform/notes-server/h.ini
      - file: /srv/webplatform/notes-server/service.sh

/srv/webplatform/notes-server/service.sh:
  file.managed:
    - source: salt://hypothesis/files/service.sh
    - mode: 755
    - require:
      - file: /srv/webplatform/notes-server

npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
    - require:
      - pkg: npm

{#
 # Nice to have?:
 #  - http://circus.readthedocs.org/en/latest/usecases/
 #
 # Ref:
 #  - http://docs.gunicorn.org/en/latest/deploy.html
 #  - https://github.com/hypothesis/h/blob/develop/INSTALL.Ubuntu.rst
 #}
include:
  - webplatform
  - nodejs
  - git
  - mmonit

ln -s /usr/bin/nodejs /usr/bin/node:
  cmd.run:
    - unless: test -f /usr/bin/node

# https://notes.webplatformstaging.org/ruok
# http://localhost:8000/ruok
/etc/monit/conf.d/hypothesis.conf:
  file.managed:
    - template: jinja
    - source: salt://hypothesis/files/monit.conf.jinja
    - context:
        elastic_host: {{ salt['pillar.get']('infra:elasticsearch:private') }}
        elastic_port: {{ salt['pillar.get']('infra:elasticsearch:port') }}
        hypothesis_host: {{ salt['pillar.get']('infra:notes:host', '127.0.0.1') }}
        hypothesis_port: {{ salt['pillar.get']('infra:notes:port', 8000) }}
    - require:
      - file: /srv/webplatform/notes-server/service.sh
    - watch_in:
      - service: monit
      - service: hypothesis

hypothesis:
  service.running:
    - enable: True
    - reload: true
    - require:
      - pkg: hypothesis-dependencies
      - file: /etc/init/hypothesis.conf

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

hypothesis-compass-dep:
  gem.installed:
    - name: compass
    - require:
      - pkg: ruby-full
      - gem: sass
 
# Make SURE this file exists, its required
# by the /etc/init/hypothesis.conf init script 
/srv/webplatform/notes-server/h.ini:
  file.exists

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
      - file: /srv/webplatform/notes-server/service.sh
      - file: /var/log/webplatform

/srv/webplatform/notes-server/service.sh:
  file.managed:
    - source: salt://hypothesis/files/service.sh
    - mode: 755
    - require:
      - file: /srv/webplatform/notes-server
      - file: /srv/webplatform/notes-server/h.ini

npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
    - require:
      - pkg: npm

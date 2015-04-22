{%- set svc_user = 'app-user' -%}
{%- set svc_group = 'www-data' -%}
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
  - users.app-user

# https://notes.webplatformstaging.org/ruok
# http://localhost:8000/ruok
/etc/monit/conf.d/h.conf:
  file.managed:
    - template: jinja
    - source: salt://hypothesis/files/monit.conf.jinja
    - context:
        elastic_host: {{ salt['pillar.get']('infra:elasticsearch:private') }}
        elastic_port: {{ salt['pillar.get']('infra:elasticsearch:port') }}
        hypothesis_host: 127.0.0.1
        hypothesis_port: {{ salt['pillar.get']('infra:notes-server:port', 8000) }}
    - watch_in:
      - service: monit
      - service: h

h:
  service.running:
    - enable: True
    - reload: true
    - require:
      - pkg: hypothesis-dependencies
      - file: /etc/init/h.conf

hypothesis-dependencies:
  pkg.installed:
    - pkgs:
      - python-yaml
      - python-dev
      - python-pip
      - python-virtualenv
      - git
      - libpq-dev
      - make
      - ruby1.9.1-full
      - build-essential
      - nodejs
      - nodejs-legacy
      - npm
      - python-mysqldb
      - rubygems-integration
  gem.installed:
    - name: sass

hypothesis-compass-dep:
  gem.installed:
    - name: compass
    - require:
      - pkg: hypothesis-dependencies

# Make SURE this file exists, its required
# by the /etc/init/h.conf init script
#/srv/webplatform/notes-server/h.ini:
#  file.exists

/srv/webplatform/notes-server:
  file.directory:
    - makedirs: True
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group


/etc/init/h.conf:
  file.managed:
    - source: salt://hypothesis/files/init.h.jinja
    - template: jinja
    - mode: 755
    - context:
        svc_user: {{ svc_user }}
        svc_group: {{ svc_group }}
    - require:
      - file: /srv/webplatform/notes-server
      - file: /var/log/webplatform

npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
    - require:
      - pkg: npm

#
# Ref: https://github.com/akoumjian/salt-django-example/blob/master/salt/webserver/init.sls
#
include:
  - hypothesis

#app-pkgs:
#  pkg.installed:
#    - names:
#      - python-virtualenv
#      - python-dev
#      - libmysqlclient-dev
#    - required_in:
#      - git: hypothesis-checkout
#
#virtualenv-setup:
#  virtualenv.manage:
#    - name: /srv/webplatform/h
#    - requirements: /srv/webplatform/h/requirements.txt
#    - no_site_packages: true
#    - clear: false
#    - require:
#      - pkg: app-pkgs
#      - git: hypothesis-checkout

{% set saltPublishQuery = salt.publish.publish('salt', 'grains.get', 'level') %}

salt-minion:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: salt-minion

/etc/salt/minion.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/minion-overrides.conf
    - template: jinja
    - require:
      - pkg: salt-minion
    - context:
        level: {{ saltPublishQuery.salt }}

zeromq-ppa:
  pkgrepo.managed:
    - ppa: chris-lea/zeromq
  pkg.installed:
    - pkgs:
      - libzmq3
      - python-zmq
    - require:
      - pkgrepo: zeromq-ppa

salt-minion-deps:
  pkg.installed:
    - names:
      - python-pip

{% if salt['pillar.get']('infra:salt_testing', false) == True %}
# NOTE: salt salt pkg.get_repo "ppa:saltstack/salt"
#       https://launchpad.net/~saltstack/+archive/ubuntu/salt-testing
#
/etc/apt/sources.list.d/saltstack-salt-trusty.list:
  file.replace:
    - pattern: '\bsalt\/'
    - repl: 'salt-testing/'
{% endif %}

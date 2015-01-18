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
    - require:
      - pkg: salt-minion

salt-minion-deps:
  pkg.installed:
    - pkgs:
      - python-pip
      - python-psutil
    - require:
      - pkg: salt-minion

{% if grains['nodename'] != 'salt' %}
{% set saltPublishQuery = salt.publish.publish('salt', 'grains.get', 'level') %}
/etc/salt/grains:
  file.append:
    - require:
      - pkg: salt-minion
    - text: |
        level: {{ saltPublishQuery.salt }}
{% endif %}

{% if salt['pillar.get']('infra:salt_testing', false) == True %}
# NOTE: salt salt pkg.get_repo "ppa:saltstack/salt"
#       https://launchpad.net/~saltstack/+archive/ubuntu/salt-testing
#
/etc/apt/sources.list.d/saltstack-salt-trusty.list:
  file.replace:
    - pattern: '\bsalt\/'
    - repl: 'salt-testing/'
{% endif %}

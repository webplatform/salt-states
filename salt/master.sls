{%- set users = salt['pillar.get']('users', {}) -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}

include:
  - salt
  - users
  - mmonit

/srv/opsconfigs/userdata.txt:
  file.managed:
    - source: salt://salt/files/userdata.txt.jinja
    - template: jinja
    - context:
        level: {{ level }}
        salt_master_ip: {{ salt_master_ip }}
        # CANNOT set salt_master_ip to create new salt master
        # Looking if it works well to specify future salt master IP, before creation #TODO
        # #CHANGE_SALT_MASTER

/etc/profile.d/nova.sh:
  file.managed:
    - user: root
    - group: deployment
    - mode: 750
    - template: jinja
    - source: salt://webplatform/files/profile-nova.sh.jinja

{% for username in users %}
/home/{{ username }}/.bash_aliases:
  file.managed:
    - source: salt://salt/files/bash_aliases
    - user: {{ username }}
    - group: {{ username }}
    - require:
      - user: {{ username }}

/home/{{ username }}/.my.cnf:
  file.managed:
    - source: salt://environment/files/my.cnf.jinja
    - user: {{ username }}
    - group: {{ username }}
    - mode: 640
    - template: jinja
    - require:
      - user: {{ username }}
{% endfor %}

## SecurityGroup port: TCP 4505 4506 @salt
salt-master-deps:
  pkg.installed:
    - pkgs:
      - python-dulwich
      - python-novaclient
      - python-libcloud
      - python-cffi
      - salt-cloud
      - salt-api
      - salt-master
      - jq
      - swaks
      - gnutls-bin

#/usr/local/bin/wpd-deploy:
#  file.managed:
#    - user: root
#    - group: root
#    - source: salt://salt/files/wpd-deploy
#    - mode: 755

/etc/ssh/sshd_config:
  file.append:
    - text: Banner /etc/issue.net

/etc/issue.net:
  file.managed:
    - source: salt://salt/files/banner.txt.jinja
    - template: jinja
    - context:
        level: {{ level }}
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}

/etc/salt/master.d/reactor.conf:
  file.managed:
    - source: salt://salt/files/reactor.conf

/etc/salt/master.d/roots.conf:
  file.managed:
    - source: salt://salt/files/roots.conf

/etc/salt/master.d/runners.conf:
  file.managed:
    - source: salt://salt/files/runners.conf

/etc/salt/master.d/peers.conf:
  file.managed:
    - source: salt://salt/files/peers.conf.jinja
    - template: jinja

/etc/salt/master.d/gitfs.conf:
  file.managed:
    - source: salt://salt/files/gitfs.conf

/etc/salt/master.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/master-overrides.conf

/etc/monit/conf.d/salt-master.conf:
  file.managed:
    - source: salt://salt/files/monit.conf
    - watch_in:
      - service: monit

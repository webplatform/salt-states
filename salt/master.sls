{%- set users = salt['pillar.get']('users', {}) -%}

include:
  - salt
  - users

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

salt-master-deps:
  pkg.installed:
    - pkgs:
      - python-git
      - python-novaclient
      - salt-cloud
      - python-libcloud
      - salt-api

## SecurityGroup port: TCP 4505 4506 @salt
salt-master:
  pkg:
    - installed

#/usr/local/bin/wpd-deploy:
#  file.managed:
#    - user: root
#    - group: root
#    - source: salt://salt/files/wpd-deploy
#    - mode: 755

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

/srv/userdata.txt:
  file.managed:
    - source: salt://salt/files/userdata.txt.jinja
    - template: jinja
    - context:
        level: {{ salt['grains.get']('level', 'production') }}
        salt_master_ip: 10.10.10.129
        # Looking if it works well to specify future salt master IP, before creation #TODO

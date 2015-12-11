{%- set users = salt['pillar.get']('users', {}) -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set github_secret = salt['pillar.get']('accounts:github:secret', '') %}

include:
  - salt

{% set base64_yaml_level_line = {
   'production': 'bGV2ZWw6IHByb2R1Y3Rpb24='
  ,'staging': 'bGV2ZWw6IHN0YWdpbmc='
  ,'workbench': 'bGV2ZWw6IHdvcmtiZW5jaA=='
}.get(level) %}

/srv/ops/userdata.txt:
  file.managed:
    - source: salt://salt/files/userdata.txt.jinja
    - template: jinja
    - context:
        opts_salt_ip: {{ opts['master_ip'] }}
        level: {{ level }}
        base64_yaml_level_line: {{ base64_yaml_level_line }}
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

## SecurityGroup port: TCP 4505 4506 @salt
salt-master-deps:
  pkg.installed:
    - pkgs:
      - python-dulwich
      - python-novaclient
      - python-neutronclient
      - python-libcloud
      - python-cffi
      - salt-cloud
      - salt-api
      - salt-master
      - jq
      - swaks
      - gnutls-bin

# ref: http://hardenubuntu.com/software/install-fail2ban
setup-fail2ban:
  pkg.installed:
    - name: fail2ban
  file.managed:
    - source: salt://salt/files/fail2ban.conf
    - name: /etc/fail2ban/jail.local

/etc/ssh/sshd_config:
  file.append:
    - text: Banner /etc/issue.net

/etc/issue.net:
  file.managed:
    - source: salt://salt/files/banner.txt.jinja
    - template: jinja
    - context:
        level: {{ level }}
        tld: {{ tld }}

/etc/salt/master.d/peers.conf:
  file.managed:
    - source: salt://salt/files/peers.conf.jinja
    - template: jinja

/etc/salt/master.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/master-overrides.conf

/etc/monit/conf.d/salt-master.conf:
  file.managed:
    - source: salt://salt/files/monit.conf
    - watch_in:
      - service: monit

build-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - libterm-readkey-perl
      - percona-toolkit
      - nodejs
      - nodejs-legacy
      - npm
      - bundler
      - php5-curl
      - dpkg-dev
      - php5-dev


/etc/salt/master.d/reactor.conf:
  file.managed:
    - source: salt://salt/files/reactor.conf

/srv/reactor:
  file.directory:
    - user: root
    - group: deployment
    - makedirs: True

{% for reactor_name in [
                         'hook_github'
                        ,'minion_start'
                        ,'new_minion'] %}
/srv/reactor/{{ reactor_name }}.sls:
  file.managed:
    - source: salt://salt/files/reactor/{{ reactor_name }}.sls.jinja
    - template: jinja
    - user: root
    - group: deployment
    - context:
        github_secret: {{ github_secret }}
{% endfor %}

{%- set level = salt['grains.get']('level', 'production') -%}
{%- set users = salt['pillar.get']('users', {}) -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}

include:
  - users
  - basesystem

/var/log/webplatform:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: deployment

/srv/webplatform:
  file:
    - directory
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/apt/sources.list.d/webplatform.list:
  file.managed:
    - contents: |
        deb http://wpd.objects.dreamhost.com/packages/ apt/

## Those should superseed what the app-user had
/srv/webapps/.ssh:
  file.directory:
    - createdirs: True
    - user: webapps
    - group: webapps
    - mode: 0700
    - require:
      - file: /srv/webapps

/srv/webapps/.ssh/id_ed25519:
  file.managed:
    - contents_pillar: sshkeys:wpdci:id_ed25519:private
    - user: webapps
    - group: webapps
    - mode: 0600
    - require:
      - file: /srv/webapps/.ssh

/srv/webapps/.ssh/id_ed25519.pub:
  file.managed:
    - contents_pillar: sshkeys:wpdci:id_ed25519:public
    - user: webapps
    - group: webapps
    - mode: 0600
    - require:
      - file: /srv/webapps/.ssh

{% for username in users %}
/home/{{ username }}/.screenrc:
  file.managed:
    - mode: 640
    - source: salt://webplatform/files/screenrc.jinja
    - template: jinja
    - user: {{ username }}
    - group: {{ username }}
    - require:
      - user: {{ username }}
    - context:
        level: {{ level }}
{%- endfor %}

/etc/resolvconf/resolv.conf.d/base:
  file.managed:
    - contents: |
        search {{ level }}.wpdn
        domain {{ level }}.wpdn
        nameserver 8.8.8.8

/etc/resolvconf/resolv.conf.d/head:
  file.managed:
    - contents: |
        # Managed by Salt Stack
        # Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
        #     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
        #     salt.wpdn   # #TODO hardcoded salt-master in gdnsd zone files
        nameserver {{ salt_master_ip }}
    - require_in:
      - cmd: resolvconf -u

# apport: ref: http://hardenubuntu.com/disable-services/disable-apport
non-needed-softwares:
  pkg.purged:
    - pkgs:
      - landscape-common
      - landscape-client
      - whoopsie
      - apport
      - at
      - avahi-daemon
      - avahi-utils

commonly-used-utilities:
  pkg.installed:
    - pkgs:
      - screen
      - htop
      - monkeytail
      - vim
      - vim-common

sysdig:
  pkg.installed:
    - skip_verify: True

/usr/bin/timeout:
  file.exists

resolvconf -u:
  cmd.run:
    - unless: grep -q -e 'wpdn' /etc/resolv.conf

/etc/profile.d/wpd_aliases.sh:
  file.managed:
    - source: salt://webplatform/files/wpd_aliases.sh
    - group: deployment
    - mode: 750

/usr/local/bin/wpd-autoupdate.sh:
  file.managed:
    - source: salt://webplatform/files/wpd-autoupdate.sh
    - mode: 755

#/usr/local/bin/wpd-dependency-installer.sh:
#  file.managed:
#    - source: salt://webplatform/files/wpd-dependency-installer.sh
#    - mode: 755

##
##TODO Loop through web apps
##
#{% set appNameUpdateId = 'tmp' %}
#{% set appCodePath = 'tmp' %}
#{{ appNameUpdateId }}-crontab:
#  cron.present:
#    - identifier: {{ appNameUpdateId }}
#    - user: root
#    - hour: '*/2'
#    - name: "JOBNAME={{ appNameUpdateId }} CODE_PATH={{ appCodePath }} cronhelper.sh /usr/local/bin/wpd-autoupdate.sh"
#    - require:
#      - file: /usr/local/bin/wpd-autoupdate.sh

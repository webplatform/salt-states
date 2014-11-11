# HHVM + WordPRess ? https://gist.github.com/octalmage/11366947

{% set hhvmIniFiles = ['php.ini', 'server.ini'] %}

include:
  - mysql

hhvm-install:
  cmd.run:
    - cwd: /root
    - name: "wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -"
    - unless: test -f /etc/apt/sources.list.d/hhvm.list
  pkgrepo.managed:
    - humanname: HHVM PPA
    - name: deb http://dl.hhvm.com/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/hhvm.list

hhvm:
  pkg:
    - installed
    - require:
      - pkgrepo: deb http://dl.hhvm.com/ubuntu trusty main
  service:
    - running
    - enable: True
    - reload: True

hhvm-deps:
  pkg.installed:
    - names:
      - php5-mysqlnd
      - php5-gd
      - php5-dev
      - php5-curl
      - php-apc
      - php5-json
    - require:
      - pkg: hhvm

{% for hhvmConfig in hhvmIniFiles %}
/etc/hhvm/{{ hhvmConfig }}:
  file.append:
    - text: |
        ;
        ; Session
        hhvm.session.save_handler = memcached
        hhvm.session.path = 'localhost:11211'
    - require:
      - pkg: hhvm
{% endfor %}

#  file.managed:
#    - name: /etc/hhvm/php.ini
#    - template: jinja
#    - source: salt://hhvm/files/php.ini.jinja
#    - context:
#        serverRoot: /srv/webplatform/phabricator/webroot

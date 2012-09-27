include:
  - apache
  - php.mediawiki-apache

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}

# Initial install of MediaWiki via states
{% for slot in ['current','test'] %}
install-mediawiki-{{ slot }}:
  cmd:
    - run
    - name: salt-call state.sls mediawiki.docs_{{ slot }}
    - unless: test -d /srv/webplatform/wiki/{{ slot }}

/srv/webplatform/wiki/{{ slot }}/cache:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - require:
      - cmd: install-mediawiki-{{ slot }}
{% endfor %}

# Mount point for the glusterfs filesystem
/srv/webplatform/wiki/images:
  mount.mounted:
    - device: 10.5.152.98:/images
    - fstype: glusterfs
    - mkmnt: True
    - opts:
      - defaults
      - _netdev=eth0
      - log-level=WARNING
      - log-file=/var/log/gluster.log
    - require:
      - pkg: glusterfs-client
  file.directory:
    - user: www-data
    - group: www-data

## We can manage MediaWiki via git and branches, or tags, if we'd like
#{% for slot,branch in {'current': 'wmf/1.20wmf3','test': 'wmf/1.20wmf3' }.items() %}
#git clone https://gerrit.wikimedia.org/r/p/mediawiki/core.git {{ slot }}:
#  cmd:
#    - run
#    - cwd: /srv/webplatform/wiki
#    - unless: [ -d '/srv/webplatform/wiki/{{ slot }}' ]
#    - require:
#      - file:
#        - /srv/webplatform/wiki
#
#git branch --track {{ branch }} origin/{{ branch }}:
#  cmd:
#    - run
#    - cwd: /srv/webplatform/wiki/{{ slot }}
#    - unless: git branch | grep '{{ branch }}'
#    - require:
#      - cmd: git clone https://gerrit.wikimedia.org/r/p/mediawiki/core.git {{ slot }}
#
#git checkout {{ branch }}:
#  cmd:
#    - run
#    - cwd: /srv/webplatform/wiki/{{ slot }}
#    - unless: git branch | grep '* {{ branch }}'
#    - require:
#      - cmd: git branch --track {{ branch }} origin/{{ branch }}
#
#git submodule update --init:
#  cmd
#    - run
#    - cwd: /srv/webplatform/wiki/{{ slot }}
#    - require:
#      - cmd: git checkout {{ branch }}
#{% endfor %}

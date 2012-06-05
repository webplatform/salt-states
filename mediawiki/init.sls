include:
  - apache
  - apache.rewrite
  - apache.ssl
  - php.mediawiki
  - fonts
  - mysql

# Manage MediaWiki as a salt directory, for now.
{% for slot in ['slot0','slot1'] %}
/srv/webplatform/wiki/{{ slot }}:
  file.recurse:
    - source: salt://mediawiki/code/{{ slot }}
    - makedirs: True

/srv/webplatform/wiki/{{ slot }}/cache:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/webplatform/wiki/{{ slot }}
{% endfor %}

# Using slots for current and test allow us to quickly
# move between environments
/srv/webplatform/wiki/current:
  file.symlink:
    - target: /srv/webplatform/wiki/slot0

/srv/webplatform/wiki/Settings.php:
  file.managed:
    - source: salt://mediawiki/Settings.php
    - user: root
    - group: www-data
    - mode: 440

/srv/webplatform/wiki/test:
  file.symlink:
    - target: /srv/webplatform/wiki/slot1

## We can manage MediaWiki via git and branches, or tags, if we'd like
#{% for slot,branch in {'slot0': 'wmf/1.20wmf3','slot1': 'wmf/1.20wmf3' }.items() %}
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

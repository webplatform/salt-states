include:
  - apache
  - apache.rewrite
  - apache.ssl
  - php.mediawiki
  - fonts
  - mysql

# Initial install of MediaWiki via states
{% for slot in ['current','test'] %}
salt-call cp.get_dir salt://code/docs/{{ slot }} /srv/webplatform/wiki
  cmd:
    - run
    - unless: [ -d "/srv/webplatform/wiki/{{ slot }}" ]

/srv/webplatform/wiki/{{ slot }}/cache:
  file.directory:
    - mode: 755
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/webplatform/wiki/{{ slot }}
{% endfor %}

# Always manage Settings file via states
/srv/webplatform/wiki/Settings.php:
  file.managed:
    - source: salt://mediawiki/Settings.php
    - user: root
    - group: www-data
    - mode: 440

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

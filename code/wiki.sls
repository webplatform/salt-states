# Include the common settings for the docs repo
include:
  - code.prereq
  - rsync.secret

{%- set envNames = ['wpwiki', 'wptestwiki'] -%}

{% for env in envNames %}

/srv/webplatform/wiki/{{ env }}:
  file.directory:
    - makedirs: True

/srv/webplatform/wiki/{{ env }}/mediawiki/LocalSettings.php:
  file.managed:
    - source: salt://code/files/wiki/LocalSettings.php.jinja
    - template: jinja

/srv/webplatform/wiki/{{ env }}/cache:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/webplatform/wiki/{{ env }}
    - recurse:
      - user
      - group

/srv/webplatform/wiki/{{ env }}/logs:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/webplatform/wiki/{{ env }}
    - recurse:
      - user
      - group

/srv/webplatform/wiki/{{ env }}/local.d:
  file.recurse:
    - source: salt://code/files/wiki/{{ env }}
    - require:
      - file: /srv/webplatform/wiki/{{ env }}

rsync-run-{{ env }}:
  cmd.run:
    - name: "rsync -a --exclude '.git' --exclude '.svn' --exclude 'LocalSettings.php' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.wpdn::code/wiki/repo/ /srv/webplatform/wiki/{{ env }}/"
    - user: root
    - group: root
    - require_in:
      - file: /srv/webplatform/wiki/{{ env }}/cache
      - file: /srv/webplatform/wiki/{{ env }}/mediawiki/LocalSettings.php
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
      - file: /srv/webplatform/wiki/{{ env }}
  file.managed:
    - name: /srv/webplatform/wiki/{{ env }}/LocalSettings.php
    - source: salt://code/files/wiki/{{ env }}.php.jinja
    - template: jinja
    - require:
      - file: /srv/webplatform/wiki/Settings.php
{% endfor %}

/srv/webplatform/wiki/Settings.php:
  file.managed:
    - source: salt://code/files/wiki/Settings.php.jinja
    - template: jinja


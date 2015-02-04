include:
  - code.packages

salt-specific-packages:
  pkg.installed:
    - pkgs:
      - udplog
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list

libboost-program-options1.46.1:
  pkg.installed:
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list

/srv/code/piwik/setup.sh:
  file.managed:
    - source: salt://code/files/piwik/setup.sh
    - user: nobody
    - group: deployment
    - mode: 774

/srv/code/wiki/setup.sh:
  file.managed:
    - source: salt://code/files/wiki/setup.sh
    - user: nobody
    - group: deployment
    - mode: 774

/srv/code/web25ee/setup.sh:
  file.managed:
    - source: salt://code/files/web25ee/setup.sh
    - user: nobody
    - group: deployment
    - mode: 774

/srv/code/buggenie/setup.sh:
  file.managed:
    - source: salt://code/files/buggenie/setup.sh
    - user: nobody
    - group: deployment
    - mode: 774

/srv/code/notes-server/setup.sh:
  file.managed:
    - source: salt://code/files/notes-server/setup.sh
    - user: nobody
    - group: deployment
    - mode: 774

#/srv/code/webspecs_bikeshed/setup.sh:
#  file.managed:
#    - source: salt://code/files/webspecs_bikeshed/setup.sh
#    - user: nobody
#    - group: deployment
#    - mode: 774

/srv/code/www/repo/compile.sh:
  file.managed:
    - source: salt://code/files/www/compile.sh
    - mode: 775
    - user: nobody
    - group: deployment

#/srv/code/specs/repo/compile.sh:
#  file.managed:
#    - source: salt://code/files/specs/compile.sh
#    - mode: 775
#    - user: nobody
#    - group: deployment

# See also in code.piwik
/srv/code/piwik/repo/config/config.ini.php:
  file.managed:
    - template: jinja
    - source: salt://code/files/piwik/config.ini.php.jinja

# See also in code.buggenie
/srv/code/buggenie/repo/core/b2db_bootstrap.inc.php:
  file.managed:
    - source: salt://code/files/buggenie/b2db_bootstrap.inc.php.jinja
    - template: jinja

/srv/code/www/repo/docpad.js:
  file.managed:
    - template: jinja
    - source: salt://code/files/www/docpad.js.jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}


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

/srv/code/wiki/setup.sh:
  file.managed:
    - source: salt://code/files/wiki/setup.sh

/srv/code/web25ee/setup.sh:
  file.managed:
    - source: salt://code/files/web25ee/setup.sh

# See also in code.piwik.config config patch
/srv/code/piwik/repo/config/config.ini.php:
  file.managed:
    - template: jinja
    - source: salt://piwik/files/config.ini.php.jinja


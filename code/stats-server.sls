{%- set unpack = salt['pillar.get']('basesystem:stats:unpacker_archives') %}

include:
  - rsync.secret
  - code.prereq
  - code.certificates
  - users.app-user

{% from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}
{{ unpack_remote_loop(unpack)}}

/srv/webplatform/stats-server:
  file.directory:
    - user: app-user
    - group: www-data
    - require:
      - file: Packager unpack /srv/webplatform/stats-server
      - user: app-user
    - recurse:
      - user
      - group

/srv/webplatform/stats-server/config/config.ini.php:
  file.managed:
    - source: salt://code/files/stats-server/config.ini.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - makedirs: True
    - require:
      - file: Packager unpack /srv/webplatform/stats-server

/srv/webplatform/stats-server/bootstrap.php:
  file.managed:
    - source: salt://code/files/stats-server/bootstrap.php.jinja
    - template: jinja
    - user: app-user
    - group: www-data
    - require:
      - file: Packager unpack /srv/webplatform/stats-server


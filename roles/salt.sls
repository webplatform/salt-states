{%- set srv_code_repos = salt['pillar.get']('basesystem:salt:srv_code_repos') %}
{%- set unpack = salt['pillar.get']('basesystem:salt:srv_code_unpacker_archives') %}

{%- from "basesystem/macros/git.sls" import git_clone_loop %}
{%- from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}

include:
  - code.packages
  - salt._formulas

# Gotta make distinction between auth user and owner #TODO
{% set inject = {
    'auth_key': '/srv/webapps/.ssh/id_ed25519'
  }
%}

{{ git_clone_loop(srv_code_repos, inject) }}
{{ unpack_remote_loop(unpack)}}

libboost-program-options1.46.1:
  pkg.installed:
    - skip_verify: True

#/srv/code/wiki/setup.sh:
#  file.managed:
#    - source: salt://code/files/wiki/setup.sh
#    - user: nobody
#    - group: deployment
#    - mode: 774

#/srv/code/web25ee/setup.sh:
#  file.managed:
#    - source: salt://code/files/web25ee/setup.sh
#    - user: nobody
#    - group: deployment
#    - mode: 774

#/srv/code/buggenie/setup.sh:
#  file.managed:
#    - source: salt://code/files/buggenie/setup.sh
#    - user: nobody
#    - group: deployment
#    - mode: 774

#/srv/code/notes-server/setup.sh:
#  file.managed:
#    - source: salt://code/files/notes-server/setup.sh
#    - user: nobody
#    - group: deployment
#    - mode: 774

#/srv/code/www/compile.sh:
#  file.managed:
#    - source: salt://code/files/www/compile.sh
#    - mode: 775
#    - user: nobody
#    - group: deployment

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

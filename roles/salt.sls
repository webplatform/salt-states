{%- set srv_code_repos = salt['pillar.get']('basesystem:salt:srv_code_repos') -%}

{% from "basesystem/macros/git.sls" import git_clone %}

include:
  - code.packages

{% set auth_inject = {
    'user': grains['initial_user'],
    'auth_key': "/home/" ~ grains['initial_user'] ~ "/.ssh/id_rsa"
  }
%}

{#
 # Re-implementing git_clone_loop, but allow to add values
 #}
{% if srv_code_repos.items()|count >= 1 %}
{% for dir,obj in srv_code_repos.items() %}
{% do obj.update(auth_inject) %}
{{ git_clone(dir, obj.origin, obj) }}
{% endfor %}
{% endif %}

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

#/srv/code/webspecs_bikeshed/setup.sh:
#  file.managed:
#    - source: salt://code/files/webspecs_bikeshed/setup.sh
#    - user: nobody
#    - group: deployment
#    - mode: 774

#/srv/code/www/compile.sh:
#  file.managed:
#    - source: salt://code/files/www/compile.sh
#    - mode: 775
#    - user: nobody
#    - group: deployment

#/srv/code/specs/compile.sh:
#  file.managed:
#    - source: salt://code/files/specs/compile.sh
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

/srv/code/www/repo/.npmrc:
  file.managed:
    - contents: |
        ; Managed by Salt Stack by the salt master. Do NOT edit manually!
        ; https://docs.npmjs.com/files/npmrc#per-project-config-file
        cwd = .
        HOME = ../.npmhome


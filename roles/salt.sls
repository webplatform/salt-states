{%- set srv_code_repos = salt['pillar.get']('basesystem:salt:srv_code_repos') %}
{%- set unpack = salt['pillar.get']('basesystem:salt:srv_code_unpacker_archives') %}

{%- from "basesystem/macros/git.sls" import git_clone_loop %}
{%- from "basesystem/macros/unpacker.sls" import unpack_remote_loop %}

include:
  - salt._formulas

# Gotta make distinction between auth user and owner #TODO
{% set inject = {
    'auth_key': '/srv/webapps/.ssh/id_ed25519'
  }
%}

{{ git_clone_loop(srv_code_repos, inject) }}
{{ unpack_remote_loop(unpack)}}

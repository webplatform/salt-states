{%- set srv_repos = salt['pillar.get']('basesystem:salt:srv_repos') -%}

{% from "basesystem/macros/git.sls" import git_clone_loop %}

{% set auth_inject = {
    'user': grains['initial_user'],
    'auth_key': "/home/" ~ grains['initial_user'] ~ "/.ssh/id_rsa"
  }
%}

{{ git_clone_loop(srv_repos, auth_inject)}}

# Leave at the end as a Jinja include so we
# get W3C GitLab password prompt earlier
{% include "salt/_formulas.sls" %}

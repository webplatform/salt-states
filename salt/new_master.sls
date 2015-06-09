{%- set srv_repos = salt['pillar.get']('basesystem:salt:srv_repos') -%}

{% from "basesystem/macros/git.sls" import git_clone %}

{% set auth_inject = {
    'user': grains['initial_user'],
    'auth_key': "/home/" ~ grains['initial_user'] ~ "/.ssh/id_rsa"
  }
%}

{#
 # Re-implementing git_clone_loop, but allow to add values
 #}
{% if srv_repos.items()|count >= 1 %}
{% for dir,obj in srv_repos.items() %}
{% do obj.update(auth_inject) %}
{{ git_clone(dir, obj.origin, obj) }}
{% endfor %}
{% endif %}

# Leave at the end as a Jinja include so we
# get W3C GitLab password prompt earlier
{% include "salt/_formulas.sls" %}

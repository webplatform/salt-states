{%- set rolesDict = salt['grains.get']('roles') -%}
{#
 # Ref:
 #   - http://ryandlane.com/blog/2014/08/26/saltstack-masterless-bootstrapping/
 #}

include:
  - code.packages
{%- if rolesDict|length() >= 1 %}
{%- for root in opts['file_roots']['base'] %}
{%- for roleName in rolesDict %}
{%- set role_sls = 'roles/{0}.sls'.format(root, roleName) -%}
{%- if salt['file.file_exists'](role_sls) %}
  - roles.{{ roleName }}
{%- endif %}
{%- endfor %}
{%- endfor %}
{%- endif %}


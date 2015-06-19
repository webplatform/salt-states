{%- set rolesDict = salt['grains.get']('roles') -%}
{#
 # Load role state ONLY IF salt says it exists.
 #
 # Ref:
 #   - http://ryandlane.com/blog/2014/08/26/saltstack-masterless-bootstrapping/
 #}

include:
  - code.packages
{%- if rolesDict|length() >= 1 %}
{%- for roleName in rolesDict %}
{%- set role_sls = '/srv/salt/roles/' ~ roleName ~ '.sls' -%}
{# The following line requires salt-master to have a peer: line to allow 'file.file_exists' #}
{%- if salt['publish.publish']('salt', 'file.file_exists', role_sls) %}
  - roles.{{ roleName }}
{%- endif %}
{%- endfor %}
{%- endif %}


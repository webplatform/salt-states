{%- set rolesDict = salt['grains.get']('roles') -%}
{#
 # Ref:
 #   - http://ryandlane.com/blog/2014/08/26/saltstack-masterless-bootstrapping/
 #}

include:
  - code.packages
{%- if rolesDict|length() >= 1 %}
{% for roleName in rolesDict %}
  - vm.{{ roleName }}
{% endfor %}
{% endif %}


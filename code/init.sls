{%- set rolesDict = salt['grains.get']('roles') %}

{% if rolesDict|length() >= 1 %}
include:
{% for roleName in rolesDict %}
  - vm.{{ roleName }}
{% endfor %}
{% endif %}

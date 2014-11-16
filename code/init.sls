{%- set rolesDict = salt['grains.get']('roles') %}

include:
{% if rolesDict|length() >= 1 %}
  - code.packages
{% for roleName in rolesDict %}
  - vm.{{ roleName }}
{% endfor %}
{% endif %}

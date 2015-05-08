{%- set rolesDict = salt['grains.get']('roles') -%}


include:
{%- if rolesDict|length() >= 1 %}
{% for roleName in rolesDict %}
  - tasks.dreamobjects_upload.{{ roleName }}
{% endfor %}
{% endif %}


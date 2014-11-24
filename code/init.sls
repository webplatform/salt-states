{%- set rolesDict = salt['grains.get']('roles') -%}

include:
  - code.packages
{%- if rolesDict|length() >= 1 %}
{% for roleName in rolesDict %}
  - vm.{{ roleName }}
{% endfor %}
{% endif %}

{% if grains['nodename'] == 'salt' %}
/srv/code/www/repo/compile.sh:
  file.managed:
    - source: salt://code/files/www/compile.sh
    - mode: 775
    - user: nobody
    - group: deployment

/srv/code/specs/repo/compile.sh:
  file.managed:
    - source: salt://code/files/specs/compile.sh
    - mode: 775
    - user: nobody
    - group: deployment
{% endif %}

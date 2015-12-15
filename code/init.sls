{%- set rolesDict = salt['grains.get']('roles') -%}
{#
 # Load role state ONLY IF salt says it exists.
 #
 # Ref:
 #   - http://ryandlane.com/blog/2014/08/26/saltstack-masterless-bootstrapping/
 #}

{% if rolesDict|length() >= 1 %}
include:
{% for roleName in rolesDict %}
{# The following line requires salt-master to have a peer: line to allow 'file.file_exists' #}
{% if salt['publish.publish']('salt', 'file.file_exists', '/srv/salt/roles/' ~ roleName ~ '.sls') %}
  - roles.{{ roleName }}
{% endif %}
{% endfor %}
{% endif %}

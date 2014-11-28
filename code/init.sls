{%- set rolesDict = salt['grains.get']('roles') -%}
{#
 # Ref:
 #   - http://ryandlane.com/blog/2014/08/26/saltstack-masterless-bootstrapping/
 #}

include:
  - code.packages
{% for root in opts['pillar_roots']['base'] -%}
{%- if rolesDict|length() >= 1 %}
{% for roleName in rolesDict %}
{% set role_sls = 'vm/{0}.sls'.format(root, roleName) -%}
{% if salt['file.file_exists'](role_sls) %}
  - vm.{{ roleName }}
{% endif %}
{% endfor %}
{% endif %}
{% endfor -%}

# If the file.exists doesnt work, add again vm/db.sls vm/elastic.sls vm/mail.sls vm/memcache.sls vm/redis.sls vm/sessions.sls


{#
 # Copy of https://github.com/webplatform/mysql-formula.git
 # so that the state **only** manages databases.
 #
 # ref: mysql/user.sls
 #}

{% for name, user in salt['pillar.get']('mysql:user', {}).items() %}

{% set state_id = 'mysql_user_' ~ name %}
{{ state_id }}:
  mysql_user.present:
    - name: {{ name }}
  {%- if user['host'] is defined %}
    - host: |
        '{{ user['host'] }}'
  {%- endif %}
  {%- if user['password_hash'] is defined %}
    - password_hash: '{{ user['password_hash'] }}'
  {%- elif user['password'] is defined and user['password'] != None %}
    - password: '{{ user['password'] }}'
  {%- else %}
    - allow_passwordless: True
  {%- endif %}

{% for db in user['databases'] %}
{{ state_id ~ '_' ~ loop.index0 }}:
  mysql_grants.present:
    - grant: {{ db['grants']|join(",") }}
    - database: '{{ db['database'] }}.{{ db['table'] | default('*') }}'
    - grant_option: {{ db['grant_option'] | default(False) }}
    - user: {{ name }}
  {%- if user['host'] is defined %}
    - host: |
        '{{ user['host'] }}'
  {%- endif %}
  {%- if user['ssl'] is defined %}
    - SSL: True
  {%- endif %}
{% endfor %}

{% endfor %}

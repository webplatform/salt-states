{#
 # Copy of https://github.com/webplatform/mysql-formula.git
 # so that the state only manages databases.
 #
 # ref: mysql/database.sls
 #}

{% set db_states = salt['pillar.get']('mysql:database', []) %}

{% if db_states|length() > 0 %}
{% for database in db_states %}
Ensure MySQL database {{ database }} exists:
  mysql_database.present:
    - name: {{ database }}
{% endfor %}
{% endif %}

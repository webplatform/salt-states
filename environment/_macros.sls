{%- macro install_bash_aliases(username) -%}
/home/{{ username }}/.bash_aliases:
  file.managed:
    - user: {{ username }}
    - group: {{ username }}
    - require:
      - user: {{ username }}
    - source: salt://environment/files/bash_aliases
{% endmacro -%}

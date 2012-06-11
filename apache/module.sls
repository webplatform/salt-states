{% macro a2mod(module, enabled=true) -%}
{% if enabled %}
a2enmod {{ module }}:
  cmd:
    - run
    - unless: test -L /etc/apache2/mods-enabled/{{ module }}.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
{% else %}
a2dismod {{ module }}:
  cmd:
    - run
    - unless: test ! -L /etc/apache2/mods-enabled/{{ module }}.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
{% endif %}
{%- endmacro %}

{% macro phabricator_component(component) -%}
clone-{{ component }}:
  git.latest:
    - rev: master
    - target: /srv/webplatform/source/{{ component }}
    - name: https://github.com/phacility/{{ component }}.git
{%- endmacro -%}

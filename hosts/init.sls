{% for node, args in pillar.get('nodes', {}).items() -%}
hosts-entry-{{ node }}:
  host.present:
    - ip: {{ args.get('private') }}
    - names:
      - {{ node }}
      - {{ node }}.dho.wpdn
      - {{ node }}.webplatform.org
{% endfor -%}

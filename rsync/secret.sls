{% for share in pillar['rsync']['shares'] %}
{{ share['client secret file'] }}:
  file.managed:
    - template: jinja
    - source: salt://rsync/secret
    - user: root
    - group: root
    - mode: 600
    - context:
      rsync_secret: "{{ pillar['rsync']['secrets'][share['auth users']] }}"
{% endfor %}

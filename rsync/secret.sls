{% for share in pillar['rsync_shares'] %}
{{ share['client secret file'] }}:
  file.managed:
    - template: jinja
    - source: salt://rsync/secret
    - user: root
    - group: root
    - mode: 600
    - context:
      rsync_secret: "{{ pillar['rsync_secrets'][share['auth users']] }}"
{% endfor %}

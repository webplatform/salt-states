include:
  - xinetd.rsyncd

{% for share in pillar['rsync_shares'] %}
{{ share['secrets file'] }}:
  file.managed:
    - template: jinja
    - source: salt://rsync/secret
    - user: root
    - group: root
    - mode: 600
    - context:
      rsync_secret: "{{ share['auth users'] }}:{{ pillar['rsync_secrets'][share['auth users']] }}"
{% endfor %}

/etc/rsyncd.conf:
  file.managed:
    - template: jinja
    - source: salt://rsync/rsyncd.conf
    - user: root
    - group: root
    - mode: 644

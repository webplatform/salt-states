/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444

master.db.wpdn:
  file.append:
    - name: /etc/hosts
    - text: |
        {{ salt['pillar.get']('infra:db:master:private') }}	master.db.wpdn

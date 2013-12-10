/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444

extend:
  /etc/hosts:
    file.append:
      - name: /etc/hosts
      - text: |
          {{ salt['pillar.get']('infra:db:master:private') }}	master.db.wpdn
          208.113.157.157	controller controller.dho.wpdn

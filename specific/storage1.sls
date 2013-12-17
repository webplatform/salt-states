append-for-storage1:
  file.append:
    - name: /etc/hosts
    - text: |
        127.0.0.1	storage1.dho.wpdn storage1.webplatform.org storage1
    - requires:
      - file: /etc/hosts

comment-storage1:
  file.comment:
    - name: /etc/hosts
    - regex: ^{{ salt['pillar.get']('infra:storage:master:private') }}(.*)storage1
    - requires:
      - file: append-to-hosts
      - file: /etc/hosts

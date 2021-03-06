frozenice:
  group.present:
    - gid: 1011
  user.present:
    - shell: /bin/bash
    - uid: 1011
    - gid: 10001
    - groups:
      - frozenice
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

frozenice_keys:
  ssh_auth:
    - present
    - user: frozenice
    - enc: ssh-rsa
    - require:
      - user: frozenice
    - names:
      - AAAAB3NzaC1yc2EAAAABJQAAAIB0mWvWbUUjYdTeWey5BdmOQ//ocTnTSAEmsAkBGTG6bKcKx1BgTWsUYU6R2qLAgbJAbO0pquBGt9qrRv9u9emnijGdo27p4+59tpjxpTwAiyLpAEb1F89ZhEqEj3QY7zpjNnV39e4T2+JeAlJaeddCLgeBBm97s9+UL3uZSKg2lQ== wpd-frozenice

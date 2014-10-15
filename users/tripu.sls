tripu:
  group.present:
    - gid: 1007
  user.present:
    - fullname: Antonio Olmo Titos
    - shell: /bin/bash
    - uid: 1007
    - gid: 10001
    - groups:
      - tripu
      - deployment
    - require:
      - group: deployment

tripu_keys:
  ssh_auth:
    - present
    - user: tripu
    - enc: ssh-rsa
    - require:
      - user: tripu
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDSpZRB+WDVStDqCLiDPog/RethMxIDL9WVxMVr5vHrYkZn7Tw4k0L4WryBzel2oQc1RbGxqiZJkHLKGTVM5ElKbULR0BeorV46QQB3/QDRaSJrKTRM5+/GylgYDQVgD4o95pZxarltwhw+ylL/gecBJ/TmXRAo4XJsJrjkaQCCJuJWshtvS72P8bTXOdyL5xZAeIPHFZtDplRL2OiEf1Wrs0T7G6t5dnNTI8JEXLw7jVjk/LUT3CT/6+ZQEyESF7kfFH/e3YmIRBMr4lgYuhlBvFNRo4J7IVOkyqqXvOoAyR+VyLvKY9IOkyUoxHW5ptGJyi4zQ0okMpFqZxovSXkf a@olmo-titos.info

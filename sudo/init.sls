/etc/sudoers.d/ops:
  file:
    - managed
    - source: salt://sudo/group
    - user: root
    - group: root
    - mode: 0400
    - template: jinja
    - context:
      groupname: "ops"
      privileges: "ALL=(ALL) ALL"

denis:
  group.present:
    - gid: 1015
  user.present:
    - shell: /bin/bash
    - uid: 1015
    - gid: 10001
    - groups:
      - denis
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQDMlkayrGtAUkUMSKvuoLRhtodvs12tCtN8slhWdgIqtJEChLIU/0RJdWsGS4N5mWNFpYI7RRXP5bwpPhWZHKxhlrFOFFEQ5HWCfBLo/yppX+ihF29p5C3mUqvO1AcAybDQ9aOoEMIgZoD3dC4zVJJjIR4glt4+LyCT+OSo8U56CoWG/8U0jkiSDPAAOpBHH0bZMWzEqRmqh/eCJSLpmDR4dTJL4RhklEs6mtzQpYfXOKkwMT9GfPMYxU+8fk2fmL9lsVzTwya/SPG/aN1OTkum6Aq1MuyVam3e+jb4TSNBW4BqqcKhE6451exw1v4UQbfu+yU85MflGUiWbRvmp3S9:
  ssh_auth:
    - present
    - user: denis
    - enc: ssh-rsa
    - comment: denis@kekambas
    - require:
      - user: denis

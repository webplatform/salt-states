include:
  - groups.w3t
  - groups.deployment

vivien:
  group.present:
    - gid: 1009
  user.present:
    - fullname: Vivien
    - shell: /bin/bash
    - uid: 1009
    - gid: 10001
    - groups:
      - vivien
      - deployment
      - w3t
    - require:
      - group: deployment
      - group: w3t

vivien_keys:
  ssh_auth:
    - present
    - user: vivien
    - enc: ssh-rsa
    - require:
      - user: vivien
    - names:
      - AAAAB3NzaC1yc2EAAAABIwAAAIEAx+xioyZ3c3nYCga3r2nEOLWtOxiu1mQT9EdDmvT0k7ZLEZIXK2yhtZj1qy4BrgsIvudkgVpVSYXQbg9rMitIj9jUxzK5qFZJ66Fs/+9Qu6Da4hHbipc0O8YXztI+H0vU1luxYlbUPELAEsywp4qdqTKX6pXSjrcfJuVW9jjq+zk= vivien@hutz

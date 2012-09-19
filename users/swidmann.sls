swidmann:
  group.present:
    - gid: 1009
  user.present:
    - shell: /bin/bash
    - uid: 1009
    - gid: 10001
    - groups:
      - ops
      - swidmann
    - require:
      - group: swidmann
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQDZW2pVqLGfJiFYbOk4g46cLFcLv6Z52IMu6/Gce5adyo3rup4ZZD6QwdngHKUGgUhu7VBjxI1on2xFeW6PJWOXC95Lrwz5lWZVO3gAyXrmOv9swU2lq816TYhrq5RtBMeNFO7+4DrrKXb3rfPwsl9enhJla4xKSgd9kPCGPBhGQH82N0vMPPfwMx7r7enlPuF93/lY0RxYlGGmUVuuB+FgcAakE84DB87l88y0akmXFxlAlElz1paB4npod/d8SaDfsLUiv7TRNRr52EjJ6Ykmc/NQUXsUmUSNcFZJPM0wvm+vDgfWeu2MOtYW4e7IKWv37z/IK0xqT+hnfw6VaOKb:
  ssh_auth:
    - present
    - user: swidmann
    - enc: ssh-rsa
    - comment: widmann@hallowelt.biz
    - require:
      - user: swidmann

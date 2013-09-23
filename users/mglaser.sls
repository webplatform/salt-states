mglaser:
  group.present:
    - gid: 1007
  user.present:
    - shell: /bin/bash
    - uid: 1007
    - gid: 10001
    - groups:
      - mglaser
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAABIwAAAQEA0cBYYaaJMtJGLI5pyChd4dO496hD1iwqrmkkHBW7F+AOeU6hadw63Lr1kchpJH8Vcd1SzRMKhON221vxaYshFBof8q4s2cbPwaCTP+1QguK1dAykrp0S9sAI64FtjLs7D13rL0juBV3Tmyzj4iDUrcomDXaSg2aTIE//OQvLGxfeIG8L/RciYd7xUV2f7KP4O/1DfaIiXo3qJvKLzQ2NTo4jIu9mT3z6zqSh1UMtfQ2Ofe3IBHWx4+MnDsRBKIZZiAfGSsYasYlgFSZmSwi6rr/X2WM8JJsBlbEiTF28QcuD+ksCldOIYmSLUAO4ktR5siNjWjKkC1GO/x24Fxbmcw==:
  ssh_auth:
    - present
    - user: mglaser
    - enc: ssh-rsa
    - comment: glaser@hallowelt.biz
    - require:
      - user: mglaser

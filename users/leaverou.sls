leaverou:
  group.present:
    - gid: 1005
  user.present:
    - shell: /bin/bash
    - uid: 1005
    - gid: 10001
    - groups:
      - ops
      - leaverou
    - require:
      - group: leaverou
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQCiNyF8ASWp15RyNz9cL5Rk7NCybEMBDwM9XmxcDL5U55PUYUxXQTYaPTbUHC+cbyD1/6s2d7ienfNPqN78LU60NB4rHiHIv+J68Jk9NMpC3+eQTFlqZYLnqIPDqJu19vieuC9xBtGIziAoaJCDEbAWP+AodXiBY7J6ifxwgifAMLh/F9JlIZlwOGzQAigoeiX1OPg93fa2pW7/YBWjJPNj/Cz77CEnY6/FVGsAWXvccbCWe1p2Dyd6NUUYhl4Z0kqQrOJBHAEdokJeaZp819Y43XzCKfSBC88yMQVRT8e+Cxrie4jFbGlz2QIeWmrhM734xFxbltPzidLRSWrrNkxt:
  ssh_auth:
    - present
    - user: leaverou
    - enc: ssh-rsa
    - comment: leaverou@Leas-MacBaby.local
    - require:
      - user: leaverou

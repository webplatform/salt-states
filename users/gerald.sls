include:
  - groups.w3t
  - groups.deployment

gerald:
  group.present:
    - gid: 1012
  user.present:
    - fullname: Gerald
    - shell: /bin/bash
    - uid: 1012
    - gid: 10001
    - groups:
      - gerald
      - deployment
      - w3t
    - require:
      - group: deployment
      - group: w3t

gerald_keys:
  ssh_auth:
    - present
    - user: gerald
    - enc: ssh-rsa
    - require:
      - user: gerald
    - names:
      - AAAAB3NzaC1yc2EAAAABIwAAAQEAxrc21PBbUXHyqJ1UAGISCRZzBu64puGIQJRTr6+G/LIyDamZudhzfzf9tw8mYZols08JkPsur08aoJ6q1v1+5kzmRhnYxXP8Ez1yzZKuIiVVWGxV0+KF6objJF1c7E284RXTA82p0rc3pxCS+6BRA0nmhtBcAAsWXXg5myD1llo8SQjKqDrUZJttpsoE0UcvdG9AnL+5c0K8H46s1xEPEO2Ehj2V18jqgR/zQWGP+i2RWqD0UXzBAKnQJJSAeb2T5rEcbRkFw2roipWZEJScPkPI/t/GTXnJqsy4QzxUxOcRAs8WmQas++yvMpmNev/PDgvG8mCqQ4pAonX3LbEPMw== gerald@randy.local

tguild:
  group.present:
    - gid: 1010
  user.present:
    - fullname: Ted Guild
    - shell: /bin/bash
    - uid: 1010
    - gid: 10001
    - groups:
      - tguild
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

tguild_keys:
  ssh_auth:
    - present
    - user: tguild
    - enc: ssh-rsa
    - require:
      - user: tguild
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQCizzVJq68vAN1PCQTXnWHtZDKhyH69nuQvA3DhUHr0EIGb01H2c/teQkc0Mq7LcWo5vjrAvEiWq1aSrsSvLO6S0f6CTrNNObDN2ijV065k0Pv7udVgEts2cyFRT1C3stZ8aQd+jZLHGZYiofQL20SbmpZCPylHfRtB6Raf8NaaUu1EfSvsODmCXvw4kQaBAUAPZe1O6G4TNvITbCcsUGC4iz5EosKXPF8/7S99IQFyTSRD7iO5/Ho8BgQBERAv5SkKGIrWvYopL8FUyw4bsC4eHdiZN/8Pf1jgk9dO0P95HNbWuqSrkhhdRE/pTheaMpy6Y7OtXtE7SO0Ri4OVAiqf ted@kybuk

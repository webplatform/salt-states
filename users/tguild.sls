tguild:
  group.present:
    - gid: 1002
  user.present:
    - fullname: Ted Guild
    - shell: /bin/bash
    - uid: 1002
    - gid: 10001
    - groups:
      - tguild
      - deployment
    - require:
      - group: deployment

tguild_keys:
  ssh_auth:
    - present
    - user: tguild
    - enc: ssh-rsa
    - require:
      - user: tguild
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDhTcmltLZR7tnvWp+HhFQb5xd2Tc722f4LNp3ATl7c3Ru9N1pIvuKwx8eJdedNHfJ1BOd4r+9IBpaiIsONEXLldEelFPL4m88ctShy8Pj2wLz7GITq2fC7jhHR5sxG1+9OKkp3xufM6UOYpQ6wDp/uhwUtWgK2h5Ab5ADSuMgsgP43HajPN9g0KyhClsvkx+DeRdq/GSfZrmfuHPZMwJFP6B6PPZatd2At20l64t3rXTDRm5zhDDKreLVlY5ESJOZG8Ztii10j4AATdJ4MxdOdq2393Lm58YKEudJ4r0Od01FwmQRnKNIvP6KOcrVZGDRD9V5AmGj61l3dN9qPrUNR ted@pero

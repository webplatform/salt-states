garbee:
  group.present:
    - gid: 1014
  user.present:
    - shell: /bin/bash
    - uid: 1014
    - gid: 10001
    - groups:
      - ops
      - garbee
    - require:
      - group: garbee
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQCsWYSKMAYmc5vH/4Q3ZTOqNMn2TcAu1nn8tbsfEFJwF4MPJlsrmV8PtMRp94GDGTysHXBG01zvpvYUbtU6Fiqd5HJ5D1oYk2ZDMZ1qr3bJaovV4akbPR5cMpWWql8e+4QQHGEOkmgvBlRpB6gM4nEA+/M/9cOCRqlzMyPvq3/VkxLQ2+2BOdCTqAjpA1Zh2yz7RMdYAMh2VHP8riaqyyryFxC4JA8x5RQk2Xv7UFc0xHpvLqgsTyp5hOWAM8XnkWqw/N0LHX6eWaClLCYaK+Q/wQPWzJNmQT1Xxa525lfGZjCU5cu2BCTmaUgEAAsrvczi8zcxuzNYLYdADiYgiqnX:
  ssh_auth:
    - absent
    - user: garbee
    - enc: ssh-rsa
    - comment: Jonathan@Jonathan-Laptop
    - require:
      - user: garbee

estheban:
  group.present:
    - gid: 1021
  user.present:
    - fullname: Etienne Lachance <el@elcweb.ca>
    - shell: /bin/bash
    - uid: 1021
    - gid: 10001
    - groups:
      - estheban
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

/home/estheban/.screenrc:
  file.managed:
    - user: estheban
    - group: deployment
    - mode: 640
    - source: salt://environment/screenrc
    - require:
      - user: estheban

estheban_keys:
  ssh_auth:
    - present
    - user: estheban
    - enc: ssh-rsa
    - require:
      - user: estheban
    - names:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyNmP95JBNnTHAd1Drha0e/aMAL0uCWMPAPdpHhaEtV6g5O1dd8fj8ubYKBkrN6f1CnqLI7CkECJHk2e1V1+jfaKhk2fTnGmypTQT/tkpfi9z5IS7faPcs91z3U1cwpYXEzRg104CE/sib9QenFfnrXyirlbgZrX3Ix3lHhIHDHfk5VB1pcLrrH4CIEjQl+SQScJXa7vL3FVz9QkIS8AwPwFAjMY88qd208YkhxvUyy5d5MMrOTrZj6DEJpBUj3Yamy3YEAe2t19cB8DMf3p8CAM4Ujh/UeUQ0WM1hU89dv6YH5Y56k6QenPTvwZ3HrU54K6GQuKD3HSnBdrVW1xD1 el@elcweb.ca

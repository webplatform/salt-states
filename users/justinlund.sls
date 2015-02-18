justinlund:
  group.present:
    - gid: 1152
  user.present:
    - shell: /bin/bash
    - uid: 1152
    - gid: 10001
    - groups:
      - justinlund
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

justinlund_keys:
  ssh_auth.present:
    - user: justinlund
    - enc: ssh-rsa
    - require:
      - user: justinlund
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDmDOwvBkd0vlyYX40MrxaWsvc+6pJr/Cs396gNerQmGeV+W1t1zBmKlg6v7PZaJ9ighkJ/EEOU4xrxrnhBRCg1loa1nSE1JS15pp0HMIaIYLLBki6DfNxU+Dq7G50yvOX5Q8Tr7haQRfotxI5CBdJqzipbgX3Z6gOOrDfVsjVucd5uP4sszVCeyK+1/6MYGA8NlEUiBv4lDrP/RbMEoOxTjr2ck6NYzXv1vBrCMFLxi2RqvsyXtlNAZzH978XGVZpzLqnEWNP20bZ7oaczk4ZxnVVFd8HRed6V2W0vhOBReOc2SlW++kZNRtttQxcFm5NfyqShCTRBts6qH7gDlKyF jlund@scrappy.local

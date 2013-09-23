laner:
  group.present:
    - gid: 1001
  user.present:
    - shell: /bin/bash
    - uid: 1001
    - gid: 10001
    - groups:
      - laner
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQD6lKom1wW/TQzxv2t8xOezDhR/imfMKge35SiHDnau/L+Dtl6HF2rArzs1cx3lMHJEmH6Weykxo8/fbtzXsF0lYa9iu97DcMCAYHNbmqnTjgZypNXV0AU/9JZzsBY3kSNL87byddb7Pz8JVXHmChoPfP1dc6v+nzGxsE7o/dVGI25zQo99Vtt1Io4dN8lBQs81NtYKPWYDZRX/H/rN8qaCdzLng6/JpIczQBV+Jzj74v1I3XgynAu2tGmQCwbN9J1fNGUp1Fe9x6/mw2lh0mPJSwMRYfp81SjLA0doxOMRzD1qxUraRvI0x+qZW+5wkqCe7z0AqcfHmZ1/wHMa2iLr:
  ssh_auth:
    - present
    - user: laner
    - enc: ssh-rsa
    - comment: laner@Free-Public-Wifi.local
    - require:
      - user: laner

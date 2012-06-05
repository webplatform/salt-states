laner:
  group:
    - present
    - gid: 1001
  user:
    - present
    - home: /home/laner
    - shell: /bin/bash
    - uid: 1001
    - gid: 1001
    - groups:
      - ops
      - deployment
    - require:
      - group: laner
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

shepazu:
  group:
    - present
    - gid: 1002
  user:
    - present
    - home: /home/shepazu
    - shell: /bin/bash
    - uid: 1002
    - gid: 1002
    - groups:
      - ops
      - deployment
    - require:
      - group: shepazu
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAABIwAAAQEAs9jNBiTGPRAwaJV+XDlPU2AI+B8Z0JXVXFVKDorgdBdGHJdedVVqT3lBIoATNhOCKGZX4xNWcO1NVK7demguHBem7uDfPFASBER6ZKF7EauXf9axMM/nk5x6vgZtejFjeZbwrpxFIkiESlvDdwXNbKI7rT5vYybrhY3YCLCwRo9HLSLdANH5P4XvVcMenyEFG6HXEf9n7jqXOJoPgPetW26sJlBp0tRXvpPgpiLuE/lLJzMxKI8t0+87JOYyb0ARHD8dCQRpBSkR3KsyLhivlMI1ZAXQ5ctwZnuyytjYDDaxDo9t0JSpq6XwsxcNQBZhnHam1BkkuKM2tzYKr+WIyw==:
  ssh_auth:
    - present
    - user: shepazu
    - enc: ssh-rsa
    - comment: schepers@dhcp-guest-sjc17-128-107-24-134.cisco.com
    - require:
      - user: shepazu

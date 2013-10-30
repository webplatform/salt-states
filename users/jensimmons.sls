jensimmons:
  group.present:
    - gid: 1019
  user.present:
    - fullname: Jen Simmons <jen@jensimmons.com>
    - shell: /bin/bash
    - uid: 1019
    - gid: 10001
    - groups:
      - jensimmons
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

jensimmons_keys:
  ssh_auth:
    - present
    - user: jensimmons
    - enc: ssh-rsa
    - require:
      - user: jensimmons
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQCqRXGIuVFzcDE04CGWCbsIEhlRORS3o0V5h9J8OhzidSIkNFXUGS5YRJrATsA5A5fInuJLXOm1CoIx936SFA3pu2IGFEB8xqJLdirOolTzKy1c5k5OTfxiPNpyaWQVtVysX4ahLt8nSMHkuMFsSZhtF8XX+JnhpovhBCUQZ84k36kbqIaCl2gBY8x8BP9JUibbiOgj54eZqLWmeg8ftvOVmVmr5sPUonm2+9LkElGxe4i5jNPWWLiWFe76O/GlaOSpNUJOj5Oggs8g5SGaSDARq0uyHjR6hNz2PuAVcNcya1+V08Gv8WMGwOicY58rzEJsL0ogBrWpcfm0ysUZ83vJ jen@jensimmons.com

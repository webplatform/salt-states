include:
  - groups.w3t
  - groups.deployment
  - groups.ops

robin:
  group.present:
    - gid: 1010
  user.present:
    - fullname: Robin Berjon
    - shell: /bin/bash
    - uid: 1010
    - gid: 10001
    - groups:
      - robin
      - ops
      - deployment
      - w3t
    - require:
      - group: ops
      - group: deployment
      - group: w3t

robin_rsa_keys:
  ssh_auth.present:
    - user: robin
    - enc: ssh-rsa
    - require:
      - user: robin
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQC9ELeCY011Idp3BTEjiA6plOdqbIMEd5IQWYZQxIAE22floId34dib8J8hg3IDQf275aTZonU0w0BZYVb7Mfyoean8fEZGpmCfsTXnvyQm4/HL7Bi+y0iiCtegSiWnwYQsq4rh7f15VOcwB6ybUs2nqzfVwcLux3xgY2l9V24taaF1cfrV/dh37G0VOcHKrC8NcPHAMcX0F/Ez4Dd6krnU1mIjjNxsRq4+Hj8AvvSSZIp9WZj5XK5AIxZ4Xzo3GhiAcP22DYAplgXnZ4K9OwXtcLu5hMpDXEXxxniqyUjRjyD4POiMoocgnRN0ON7UlEGuTkPy8fl5yGpI/W6q42XZ root@eris
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDYxuLDBu5CjgJuV2rvmsPnnBOtu30CLtMcqPqbyidfsnXIRdC3kOKsDfTo5vqrAEpGjgYYTJVqH/TFkcWJNckg2yxdVXx0Iq4g7FwTrQ/dxz8dn8hCsBd+5JajNPlvGggEfgj11tPaEXCCOPgyayx5XRZRwEadpl0wg7ERUIYYvmp6Ts7RdaVGxQYM77Jyz6a79VdrAbZQ4tTpoxJkWzq0IBp5aPm3PAqr84XwFJ1ilWKR5be75s1eHb4n8btk3LQoXpJ6wuFEMgZZYQooc0Noaz1mJxOeJ87uX6ZSmu33KiLXI8eXOwrM/2tYMz+Dz8EI6EXjqHq46Ds74o1A3V71 root+passwordless@eris

? AAAAB3NzaC1kc3MAAAEBAOzeBhxNZA1R3rK+fUzjf/bd34S9yViSi8uf56uSxvs1b8WDLx5WH1Gy5LM8RCJsj7fv8d3ooDlpYbeVlBj1VzSGUpKkL1CuMmHspcmjHqWXaKqhHtvKLuoljsNCuGVO6sqp+JIdgClaiJNSfyt9yYBjF13b2/kleFKd5INuZx9enCNuyzxW1eR7Ce1id8Gj/hoxK/lV+oHa3F5vCcttEqxZjfdBDaae6pyGLEv3XjjJ6UAvtP1TUHs0s3ijkxzR1M5XjDITehC8wI/aQoGdYye4wfsAHcjSrp0MJWwLRwlFgTi+rDWCaG5wiEPlOJ1+n82XhDRDCD2DR7DP3o5zlZkAAAAVANGibrjV5JVHx9BXSLavCpMrVgm7AAABAGKS9VfQFOcZ20slMu7RMhaCFA75sZXiUvBoWrAZInVH8veCw5li2JiYLvi97mRn5VgpyYUL++6zHlz/meR4t8FX/+NR5c3EzicPmAwuJ0rtoGa5QMEX8tI3mC9HPCcjg2kEAbbfseDgDzSYiiyP7cdxGY0kdrfTKq+wVx+AUV4QLxaH0mKUfh7NcxUbYLT/pkIF0SYA4OlxzZ4wxbZvTLGWaZzE+2mHOyC9RRsLlujwJAZiKXBI9I3M7Itt4CSh1KNxJJ5GhFVHU72du6vZiLr1ZBULFkgNGOYveGLVH2mNZI23pNBvtQVsgz+9wfbClI/Ti9QJ8WzleK8kFUfbYlYAAAEATDCtW9c63fiWoGccBPUEmUAhlmB50StsbSdA940kLqyxutXC48fJM80W+u7QinugELzIhw3AkwWCdDx2FcvGP4UjfzgLah1wY0Zj33F5diL7MP3ODtnkvWTHJtIh/5mh6fZicz14KaHawVGjizDrFGXlmCGCrWFCOWEcvIoJN/d3WmMVOQdIyQN/foYBQOChMR7ofy3YiykV2YKloslvESIy57ec1De4lQYUiwS+PSeqc1zS9qBxgPhPA9vf4w/7RCnWaNgsp4TsTmqOSRXUpUR5HNdbkKaUaVmsNTsA1eTWy6K3MUCNG6zJ5muxmDeitS3g0QuVhzPl2bENqv7cyQ==
:
  ssh_auth.present:
    - user: robin
    - enc: ssh-dss
    - comment: robin@eris
    - require:
      - user: robin
      - ssh_auth: robin_rsa_keys


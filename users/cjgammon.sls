cjgammon:
  group.present:
    - gid: 1004
  user.present:
    - shell: /bin/bash
    - uid: 1004
    - gid: 10001
    - groups:
      - cjgammon
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQC0jpRjfJ7/gjbLijYnKOt7/oTZDw+LeRg7wVejdUfVH+vS8U5Q+hOhR7wMZGFFwBqPNHTMOJRbiTPE5ng+jIsgkNy9O4y7yMGIGJqGQjVtpzDWnvbaki/K8Vbx/+k0xhEelZDipS2n0w0pcOBiJUrfmqeksQUvEyySfpQ1JdwNLwQtLghh68C923EeG3SZlGxRwnSmYQeVJPTl5gBXNKm4U/lnS0AcwbtCU1qp3ziz57s6OF6m+i/kfcmgM2Nmk914Q//kgmSjb5imfMxhH0Dfa1k6FCgpF94+pdprOSNVD7lLcacuDQP5yOw/fDmDi/QWmsPY/QTFzKOtNPwuG5Y5:
  ssh_auth:
    - absent
    - user: cjgammon
    - enc: ssh-rsa
    - comment: GitHub@cjgammon
    - require:
      - user: cjgammon

AAAAB3NzaC1kc3MAAACBAKuaRis4wCysW28afSMNF2ssbZJWHyeF7waAu8I4JHFZwoHNJe6qi+gjZ80p3fTc3IFe6AAfENH0tTkeZxNHsRZe1fKaLeJYlujVpOpJgE+OxCYLSni0jroZPeDuxRfSxO3Iyzi7LjFBHSAqEDkZTD3K0CYKV6UkSGpoITPSwmQnAAAAFQCNWbWKqICGXvHKx8ZQeQ8zSCsedwAAAIBBymLewgFRkQGMhK56X7yYCvDxIbafHMwm+weA2ir1dDkyYPIzUOdICw56rwbsRz8+D/gtjNv3/nd1fC372DkgvWEJiQNfoPbFrWxIfKEw4BvlMj2fCH9mLKlZbLZUexwWQlxgcgn18fRciIc2Cwirj1KfplZ9xnvzk7VSZZlw9wAAAIBZbJHby/bUIKLhMTnkjkIT+ds7QMl+KTyn+9RcLo9n+4i0b7aL8DiEx6FHz8JMgxHAWGTx4ahA0LNQkMgzgy+U2WCVPzTLJ3VA7NmBb8DeuA4Y1BeeFRMzWeqzAPPUEyw6jHRM7aOh26WBanO1xc1imy2lsSzSIxo55+nMa5Pu0w==:
  ssh_auth:
    - present
    - user: cjgammon
    - enc: ssh-dss
    - comment: gammon@gammon-MacBookPro
    - require:
      - user: cjgammon

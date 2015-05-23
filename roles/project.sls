# Role we use to run BugGenie
# It has to have a public IP address

# TODO: This role should eventually be refactored be as an upstream,
# and be exposed only through roles.frontend
# see: https://github.com/webplatform/ops/issues/115

# TODO: We might phase out BugGenie in favor to something else

include:
  - code.buggenie
  - code.www
  - code.certificates


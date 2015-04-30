# Role we use to run WordPress
# We need at least one, typically called blog1
# It has to have a public IP address

# This role should eventually be refactored be as an upstream,
# and be exposed only through roles.frontend
# see: https://github.com/webplatform/ops/issues/115

include:
  - code.blog
  - code.www


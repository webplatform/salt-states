# Role we use to run MediaWiki instances
# We generally run three, typically called app1 where the lowest number is the one we set as "first" in Docs Fastly service.
# It has to have a public IP address

# This role should eventually be refactored be as an upstream,
# and be exposed only through roles.frontend
# see: https://github.com/webplatform/ops/issues/115

include:
  - code.wiki
  - code.certificates
  - code.compat
  - code.lumberjack-web
  - code.dabblet
  - code.www
  - code.root-com


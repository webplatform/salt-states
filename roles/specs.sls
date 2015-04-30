# Role we use for specs backend, a Docker container would regenerate the specs and be proxied by frontend
# We need at least one, typically called 'upstream-piwik'

include:
  - code.specs

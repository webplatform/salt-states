# Role to use to run an app server, hidden from the public but to run internal utilities
# We need at least one, typically called app-jobrunner

include:
  - roles.app
  - mediawiki.jobrunner


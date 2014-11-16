# ref: https://github.com/nodesource/distributions/issues/13
include:
  - git

build-essential:
  pkg.installed

nodejs:
  pkg.installed

npm:
  pkg.installed:
    - require:
      - pkg: nodejs

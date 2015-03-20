# ref: https://github.com/nodesource/distributions/issues/13
include:
  - git

build-essential:
  pkg.installed

nodejs:
  pkg.installed:
    - pkgs:
      - nodejs
      - nodejs-legacy

npm:
  pkg.installed:
    - require:
      - pkg: nodejs

# Use update-alternatives instead of nodejs-legacy #TODO
#update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10


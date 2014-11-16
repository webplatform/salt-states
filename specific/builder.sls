#
#
# TODO: Split build process from hypothesis server so what packages
#       hypothes.is isn’t  the same as where it was compiled/built
#
include:
  - nodejs
  - git
  - builder
#   ^ until we separate specific builder appropriately #TODO

hypothesis-dependencies:
  pkg.installed:
    - names:
      - nodejs
      - npm
      - docker.io

/usr/local/bin/docker:
  file.symlink:
    - target: /usr/bin/docker.io

required-gems:
  cmd.run:
    - name: gem install compass sass
    - unless: /srv/webplatform/h/h.ini
    - require:
      - pkg: ruby-full

npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
      - underscore-cli
    - require:
      - pkg: npm

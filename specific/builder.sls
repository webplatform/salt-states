#
#
# TODO: Split build process from hypothesis server so what packages
#       hypothes.is isn’t  the same as where it was compiled/built
#
include:
  - nodejs
  - git

hypothesis-dependencies:
  pkg.installed:
    - names:
      - make
      - ruby-full
      - build-essential
      - checkinstall
      - nodejs
      - nodejs-legacy
      - npm
      - python-virtualenv
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

nginx:
  pkg:
    - latest
  service:
    - running

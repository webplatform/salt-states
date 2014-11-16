include:
  - nodejs
  - git
  - builder

# Separate this from hypothesis build #TODO

builder-dependencies:
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

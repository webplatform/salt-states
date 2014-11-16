include:
  - nodejs
  - git
  - builder

# Move docker in its own? #TODO

docker-dependencies:
  pkg.installed:
    - names:
      - docker.io

/usr/local/bin/docker:
  file.symlink:
    - target: /usr/bin/docker.io


# Separate this from hypothesis build #TODO

hypothesis-required-gems:
  cmd.run:
    - name: gem install compass sass
    - unless: /srv/webplatform/h/h.ini
    - require:
      - pkg: ruby-full

hypothesis-npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
      - underscore-cli
    - require:
      - pkg: npm

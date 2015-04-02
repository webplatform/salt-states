include:
  - git

builder-dependencies:
  pkg.installed:
    - pkgs:
      - make
      - ruby-full
      - build-essential
      - checkinstall
      - python-virtualenv
      - autoconf
      - automake
      - autotools-dev

/srv/builder:
  file.directory:
    - user: renoirb
    - group: deployment

fpm-builder-deps:
  gem.installed:
    - names:
      - fpm
      - fpm-cookery
    - require:
      - pkg: builder-dependencies

hypothesis-required-gems:
  cmd.run:
    - name: gem install compass sass
    - unless: /srv/webplatform/h/h.ini
    - require:
      - pkg: builder-dependencies

hypothesis-npm-packages:
  npm.installed:
    - names:
      - uglify-js
      - clean-css
      - coffee-script
      - underscore-cli
    - require:
      - pkg: builder-dependencies


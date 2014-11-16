include:
  - git

builder-dependencies:
  pkg.installed:
    - names:
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
      - pkg: ruby-full

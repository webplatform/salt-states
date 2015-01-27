/root/.my.cnf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - source: salt://environment/files/my.cnf.jinja

build-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - libterm-readkey-perl
      - percona-toolkit
      - nodejs
      - nodejs-legacy
      - npm
      - bundler
      - php5-curl
      - dpkg-dev
      - php5-dev


/etc/ssh/sshd_config:
  file.append:
    - text: Banner /etc/issue.net

/etc/issue.net:
  file.managed:
    - source: salt://environment/issue.net

/etc/profile.d/nova.sh:
  file.managed:
    - user: root
    - group: deployment
    - mode: 640
    - template: jinja
    - source: salt://environment/files/nova-profile.sh.jinja

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

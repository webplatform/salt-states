/etc/bash.bashrc:
  file:
    - managed
    - source: salt://environment/bash.bashrc
    - user: root
    - group: root
    - mode: 644 

/etc/profile.d/Z99-nova.sh:
  file.managed:
    - user: root
    - group: ops
    - mode: 640
    - source: salt://environment/nova-profile.sh

/root/.my.cnf:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - source: salt://environment/my.cnf

useful-pkgs:
  pkg.installed:
    - pkgs:
      - build-essential

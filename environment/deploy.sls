#  libterm-readkey-perl percona-toolkit
/usr/local/bin/deploy.sh:
  file.managed:
    - user: root
    - group: root
    - source: salt://environment/deploy.sh
    - mode: 755

include:
  - builder

/srv/builder/etcd/Makefile:
  file.managed:
    - source: salt://etcd/files/fpm.makefile
    - mode: 755
    - require:
      - file: /srv/builder/etcd

/srv/builder/etcd:
  file.directory

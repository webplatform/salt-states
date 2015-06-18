mariadb-apt-repo:
  pkgrepo.managed:
    - name: deb http://ftp.osuosl.org/pub/mariadb/repo/10.1/ubuntu trusty main
    - humanname: MariaDB Repositories
    - keyserver: keyserver.ubuntu.com
    - keyid: 1BB943DB
    - file: /etc/apt/sources.list.d/mariadb.list

mysql:
  pkg.installed:
    - name: mariadb-client-10.1
    - require:
      - pkgrepo: mariadb-apt-repo
  file.managed:
    - name: /etc/mysql/conf.d/unicode-client.cnf
    - source: salt://mysql/files/unicode-client.cnf
    - mode: 644

/etc/apt/preferences.d/00-mariadb.pref:
  file.managed:
    - source: salt://mysql/files/mariadb.apt.pref
    - require:
      - pkgrepo: mariadb-apt-repo

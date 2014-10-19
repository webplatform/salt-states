percona-apt-repo:
  pkgrepo.managed:
    - name: deb http://repo.percona.com/apt trusty main
    - humanname: Percona apt Repository
    - keyserver: keys.gnupg.net
    - keyid: 1C4CBDCDCD2EFD2A
    - file: /etc/apt/sources.list.d/percona.list

percona-xtradb-cluster-client-5.6:
  pkg.installed:
    - require:
      - pkgrepo: percona-apt-repo

/etc/apt/preferences.d/00percona.pref:
  file.managed:
    - source: salt://mysql/files/percona.apt.pref
    - require:
      - pkgrepo: percona-apt-repo

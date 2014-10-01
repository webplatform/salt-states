include:
  - mysql.cluster-client

deb http://repo.percona.com/apt trusty main:
  pkgrepo.managed:
    - humanname: Percona apt Repository
    - keyserver: keys.gnupg.net
    - keyid: 1C4CBDCDCD2EFD2A
    - file: /etc/apt/sources.list.d/percona.list

/etc/apt/preferences.d/00percona.pref:
  file.managed:
    - source: salt://mysql/files/percona.apt.pref

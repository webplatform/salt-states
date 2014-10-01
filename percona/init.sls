percona-repos:
  pkgrepo.managed:
    - humanname: Percona apt Repository
    - name: deb http://repo.percona.com/apt precise main
    - keyserver: keys.gnupg.net
    - keyid: 1C4CBDCDCD2EFD2A
    - file: /etc/apt/sources.list.d/percona.list

/etc/apt/preferences.d/00percona.pref:
  file.managed:
    - source: salt://percona/files/prefences.apt.conf

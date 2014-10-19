##
## Install nutcracker if its not installed
##
## ref: http://superuser.com/questions/427318/test-if-a-package-is-installed-in-apt
##
dpkg -i /srv/webplatform/packages/nutcracker_0.3.0-1_amd64.deb:
  cmd.run:
    - unless: dpkg-query -Wf'${db:Status-abbrev}' nutcracker 2>/dev/null | grep -q '^i'
    - require:
      - file: /srv/webplatform/packages/nutcracker_0.3.0-1_amd64.deb


/srv/webplatform/packages/nutcracker_0.3.0-1_amd64.deb:
  file.exists


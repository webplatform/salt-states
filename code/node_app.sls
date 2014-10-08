include:
  - code.certificates
  - code.packages
  - code.compat
  - code.lumberjack
  - code.dabblet
  - code.www
  - code.root-com
  - code.specs

##
## Install udplog if its not installed
##
## ref: http://superuser.com/questions/427318/test-if-a-package-is-installed-in-apt
##
dpkg -i /srv/webplatform/packages/nutcracker_0.3.0-1_amd64.deb /srv/webplatform/packages/php5-igbinary_1.1.1-2_amd64.deb:
  cmd.run:
    - unless: dpkg-query -Wf'${db:Status-abbrev}' nutcracker 2>/dev/null | grep -q '^i'

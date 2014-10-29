include:
  - code.packages


##
## Install udplog if its not installed
##
## ref: http://superuser.com/questions/427318/test-if-a-package-is-installed-in-apt
##
dpkg -i /srv/code/packages/udplog_1.8-5~precise_amd64.deb /srv/code/packages/libboost-program-options1.46.1_1.46.1-7ubuntu3_amd64.deb:
  cmd.run:
    - unless: dpkg-query -Wf'${db:Status-abbrev}' udplog 2>/dev/null | grep -q '^i'
    - require:
      - sls: code.packages
  file.exists:
    - name: /srv/code/packages/udplog_1.8-5~precise_amd64.deb

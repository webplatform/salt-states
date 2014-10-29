include:
  - code.certificates
  - code.packages
  - code.compat
  - code.lumberjack-web
  - code.dabblet
  - code.www
  - code.root-com
  - code.specs
  - nutcracker.install
  - php

##
## ref: http://superuser.com/questions/427318/test-if-a-package-is-installed-in-apt
##
dpkg -i /srv/webplatform/packages/php5-igbinary_1.1.1-2_amd64.deb:
  cmd.run:
    - unless: dpkg-query -Wf'${db:Status-abbrev}' php5-igbinary 2>/dev/null | grep -q '^i'
    - require:
      - file: /srv/webplatform/packages/php5-igbinary_1.1.1-2_amd64.deb
      - pkg: php-pear

/srv/webplatform/packages/php5-igbinary_1.1.1-2_amd64.deb:
  file.exists


include:
  - code.wiki
  - code.certificates
  - code.packages
  - code.compat
  - code.lumberjack-web
  - code.dabblet
  - code.www
  - code.root-com
  - code.specs
  - nutcracker
  - php

php5-igbinary:
  pkg.installed:
    - skip_verify: True
    - require:
      - pkg: php-pear
      - file: /etc/apt/sources.list.d/webplatform.list

include:
  - code.blog
  - code.packages
  - code.www
  - nutcracker
  - php

php5-igbinary:
  pkg.installed:
    - skip_verify: True
    - require:
      - pkg: php-pear
      - file: /etc/apt/sources.list.d/webplatform.list

include:
  - code.piwik
  - code.packages
  - php
  - nutcracker

php5-igbinary:
  pkg.installed:
    - skip_verify: True
    - require:
      - pkg: php-pear
      - file: /etc/apt/sources.list.d/webplatform.list

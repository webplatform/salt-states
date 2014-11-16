include:
  - code.packages

salt-specific-packages:
  pkg.installed:
    - pkgs:
      - udplog
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list

libboost-program-options:
  pkg.installed:
    - skip_verify: True
    - version: 1.46.1-7ubuntu3
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list

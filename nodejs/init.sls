# ref: https://github.com/nodesource/distributions/issues/13

nodejs:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_4.x trusty main
    - humanname: Node Source key
    - keyserver: keyserver.ubuntu.com
    - keyid: AA01DA2C
    - file: /etc/apt/sources.list.d/nodesource.list
    - refresh_db: True
    - require:
      - pkg: apt-transport-https
  pkg.installed:
    - version: 4.2.3-1nodesource1~trusty1
    - refresh: True

npm:
  pkg:
    - installed
    - watch:
      - pkg: nodejs
  cmd.run:
    - name: npm install npm@latest -g

npm-repo:
  pkgrepo.managed:
    - ppa: chris-lea/node.js
    - require_in:
      - pkg: nodejs

build-essential:
  pkg.installed

nodejs:
  pkg.latest

npm:
  pkg.installed:
    - require:
      - pkg: nodejs

npm-config-ssl-hack:
  cmd.run:
    - name: 'npm config set registry="http://registry.npmjs.org/"'
    - require:
      - pkg: npm
    - onlyif: "cat /home/vagrant/npm-log.log | grep 'SSL Error: SELF_SIGNED_CERT_IN_CHAIN'"

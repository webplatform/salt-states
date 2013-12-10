halite-requirements:
  pkg.installed:
    - names:
      - python-pip
      - python-gevent
      - gcc
      - python-dev
      - libevent-dev

halite-pip-modules:
  pip.installed:
    - names:
      - CherryPy
      - gevent
      - halite
    - require:
      - pkg: python-pip

/etc/salt/master.d/halite.conf:
  file.managed:
    - source: salt://halite/files/halite.conf.jinja
    - template: jinja
    - requires:
      - pip: halite
  cmd.run:
    - name: salt-call --local tls.create_self_signed_cert halite CN='deployment.dho.webplatform.org' ST='MA' L='Cambridge' O='W3C' OU='WebPlatform Docs' emailAddress='team-webplatform-systems@w3.org'
    - unless: /etc/pki/halite/certs/deployment.dho.webplatform.org.crt
    - require_in: 
      - file: /etc/salt/master.d/halite.conf

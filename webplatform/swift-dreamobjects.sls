python-swiftclient-install:
  pip.installed:
    - name: python-swiftclient
    - require:
      - pkg: python-pip
  pkg.installed:
    - names:
      - python-pip
      - python-keystoneclient

/etc/profile.d/swift-dreamobjects.sh:
  file.managed:
    - mode: 755
    - template: jinja
    - source: salt://webplatform/files/swift-dreamobjects.sh.jinja
    - require:
      - pip: python-swiftclient

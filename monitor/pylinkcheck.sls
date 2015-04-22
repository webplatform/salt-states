pylinkchecker-requirements:
  pkg.installed:
    - names:
      - python-gevent
      - python-pip

pylinkvalidator:
  pip:
    - installed
    - require:
      - pkg: python-pip
      - pkg: python-gevent

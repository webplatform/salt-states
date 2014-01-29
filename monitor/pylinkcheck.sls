pylinkchecker-requirements:
  pkg.installed:
    - names:
      - python-gevent 
      - python-pip

pylinkchecker:
  pip:
    - installed
    - require:
      - pkg: python-pip
      - pkg: python-gevent

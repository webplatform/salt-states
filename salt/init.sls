/etc/salt/minion.d/overrides.conf:
  file.managed:
    - source: salt://salt/files/minion-overrides.conf

salt-minion-deps:
  pkg.installed:
    - names:
      - python-pip

# ref: 
#   - https://binstar.org/pypi/python-etcd
#   - http://pip.readthedocs.org/en/latest/reference/pip_install.html

python-etcd:
  pip.installed:
    - index_url: https://pypi.binstar.org/pypi/simple
    - require:
      - pkg: python-pip




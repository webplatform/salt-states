include:
  - builder

/srv/builder/etcd/Makefile:
  file.managed:
    - source: salt://etcd/files/fpm.makefile
    - mode: 755
    - require:
      - file: /srv/builder/etcd

/srv/builder/etcd:
  file.directory

# apt-get install -y python-dev libffi-dev libssl-dev
# pip install python-etcd
# mkdir building-python-etcd
# cd building-python-etcd/
# git clone https://github.com/jplana/python-etcd.git
# cd python-etcd
# sudo python setup.py install
#
# Ref:
#   - https://github.com/specialunderwear/debianize.sh

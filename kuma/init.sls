requirements:
  pkg.installed:
    - names:
      - python-pip
      - python-dev
      - libmemcached6
      - libmemcached-dev
      - libxslt1.1
      - libxslt-dev
      - libxml2-dev
      - libtidy-0.99-0
      - libjpeg8
      - libmagic1
      - libmysqlclient-dev

# Install required python dependencies via pip
pip-dependencies:
  cmd:
    - run
    - name: pip install -r /srv/webplatform/kuma/requirements/compiled.txt


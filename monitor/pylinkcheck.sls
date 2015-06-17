pylinkchecker-requirements:
  pkg.installed:
    - pkgs:
      - python-gevent
      - python-pip

pylinkvalidator:
  pip.installed

/srv/pylinkcheck/check-pages.sh:
  file.managed:
    - makedirs: True
    - mode: 755
    - source: salt://monitor/files/check-pages.sh.jinja
    - template: jinja
  cron.present:
    - identifier: check-pages
    - user: webapps
    - minute: random

/srv/pylinkcheck:
  file.directory:
    - user: webapps
    - group: webapps
    - makedirs: True
    - recurse:
      - user
      - group


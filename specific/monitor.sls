include:
  - webplatform
  - monitor.pylinkcheck

/srv/webplatform/pylinkcheck:
  file.directory:
    - user: nobody
    - group: ops
    - makedirs: True
    - recurse:
      - user
      - group

/srv/webplatform/pylinkcheck/check-pages.sh:
  file.managed:
    - mode: 755
    - source: salt://monitor/files/check-pages.sh.jinja
    - template: jinja
    - require:
      - file: /srv/webplatform/pylinkcheck
      - file: /srv/webplatform
      - pip:  pylinkchecker
  cron.present:
    - user: www-data
    - minute: random

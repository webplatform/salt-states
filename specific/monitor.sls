include:
  - webplatform
  - monitor.pylinkcheck
  - hosts

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
    - identifier: check-pages
    - user: www-data
    - minute: random

extend:
  /etc/hosts:
    file.append:
      - text: |
          208.113.157.157 controller
          208.113.157.158 compute1
          208.113.157.159 compute2
          208.113.157.160 compute3

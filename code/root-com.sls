include:
  - code.prereq

/srv/webplatform/webplatform-com:
  file.recurse:
    - source: salt://code/files/root-com
    - user: www-data
    - group: www-data
    - makedirs: True
    - recurse:
      - user
      - group
    - require:
      - file: webplatform-sources

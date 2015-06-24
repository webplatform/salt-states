{%- set upstream_port = salt['pillar.get']('upstream:wordpress:port', 8007) %}

include:
  - apache

/etc/apache2/sites-available/blog.conf:
  file.managed:
    - source: salt://apache/blog
    - template: jinja
    - user: root
    - group: root
    - mode: 444
    - context:
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/02-blog.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/blog.conf
    - require:
      - file: /etc/apache2/sites-available/blog.conf
    - watch_in:
      - service: apache2

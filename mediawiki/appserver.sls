include:
  - apache
  - php.mediawiki-apache
  - glusterfs
  - php

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}

# Initial install of MediaWiki via states
{% for slot in ['current','test'] %}
install-mediawiki-{{ slot }}:
  cmd:
    - run
    - name: salt-call state.sls mediawiki.docs_{{ slot }}
    - unless: test -d /srv/webplatform/wiki/{{ slot }}

/srv/webplatform/wiki/{{ slot }}/cache:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
{% endfor %}

# Mount point for the glusterfs filesystem
/srv/webplatform/wiki/images:
  mount.mounted:
    - device: {{ salt['pillar.get']('infra:storage:master:wiki-images') }}
    - fstype: glusterfs
    - mkmnt: True
    - opts:
      - defaults
      - _netdev=eth0
      - log-level=WARNING
      - log-file=/var/log/gluster.log
    - require:
      - pkg: glusterfs-client
      - file: /srv/webplatform/wiki/images
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True

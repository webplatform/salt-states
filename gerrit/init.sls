include:
  - java.openjdk
  - git

gitweb:
  pkg:
    - installed
    - require:
      - sls: git 

/var/lib/gerrit2:
  file.directory:
    - user: gerrit2
    - group: gerrit2
    - makedirs: True
    - recurse:
      - user
      - group

gerrit2:
  user.present:
    - system: True
    - gid_from_name: True
    - home: /var/lib/gerrit2
    - shell: /bin/bash
    - require:
      - file: /var/lib/gerrit2

/etc/default/gerrit:
  file.managed:
    - user: root
    - group: root
    - source: salt://gerrit/files/etc.default

{% for dir in ['bin', 'etc'] %}
/var/lib/gerrit2/review_site/{{ dir }}:
  file.directory:
    - user: gerrit2
    - group: gerrit2
    - mode: 755
    - makedirs: True
    - require:
      - user: gerrit2
{% endfor %}

{% for dir in ['logs', 'tmp', 'cache'] %}
/var/lib/gerrit2/review_site/{{ dir }}:
  file.directory:
    - user: gerrit2
    - group: gerrit2
    - mode: 755
    - makedirs: True
    - require:
      - user: gerrit2
{% endfor %}

/var/lib/gerrit2/review_site/bin/gerrit.war:
  file.managed:
    - user: gerrit2
    - group: gerrit2
    - mode: 444
    - source: salt://gerrit/files/gerrit-current.war
    - require:
      - file: /var/lib/gerrit2/review_site/bin
      - pkg: openjdk-6-jdk
      - user: gerrit2

/var/lib/gerrit2/review_site/etc/gerrit.config:
  file.managed:
    - user: gerrit2
    - group: gerrit2
    - mode: 444
    - source: salt://gerrit/files/gerrit.config.jinja
    - template: jinja
    - require:
      - file: /var/lib/gerrit2/review_site/etc
      - user: gerrit2

/var/lib/gerrit2/review_site/etc/secure.config:
  file.managed:
    - user: gerrit2
    - group: gerrit2
    - mode: 444
    - source: salt://gerrit/files/secure.config.jinja
    - template: jinja
    - require:
      - file: /var/lib/gerrit2/review_site/etc
      - user: gerrit2

{% for modfile in ['GerritSiteHeader.html', 'GerritSite.css'] %}
/var/lib/gerrit2/review_site/etc/{{ modfile }}: 
  file.managed:
    - user: gerrit2
    - group: gerrit2
    - source: salt://gerrit/files/{{ modfile }}
    - require:
      - file: /var/lib/gerrit2/review_site/etc/gerrit.config
{% endfor %}

/mnt/git:
  file.directory:
    - user: gerrit2
    - group: gerrit2
    - mode: 755
    - require:
      - user: gerrit2

/etc/init.d/gerrit:
  file.symlink:
    - target: /var/lib/gerrit2/review_site/bin/gerrit.sh
    - requires:
      - file: /var/lib/gerrit2/review_site/bin/gerrit.war

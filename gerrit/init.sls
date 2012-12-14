include:
  - java.openjdk

gerrit2:
  user.present:
    - system: True
    - gid_from_name: True
    - home: /var/lib/gerrit2
    - shell: /bin/bash

{% for dir in ['bin', 'etc'] %}
/var/lib/gerrit2/review_site/{{ dir }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - user: gerrit2
{% endfor %}

{% for dir in ['logs', 'tmp', 'cache'] %}
/var/lib/gerrit2/review_site/{{ dir }}:
  file.directory:
    - user: gerrit2
    - group: gerrit2
    - mode: 755
    - require:
      - user: gerrit2
{% endfor %}

/var/lib/gerrit2/review_site/bin/gerrit.war:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://gerrit/gerrit-full-2.5-rc0.war
    - require:
      - file: /var/lib/gerrit2/review_site/bin
      - pkg: openjdk-6-jdk

/var/lib/gerrit2/review_site/etc/gerrit.config:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://gerrit/gerrit.config
    - template: jinja
    - require:
      - file: /var/lib/gerrit2/review_site/etc

/var/lib/gerrit2/review_site/etc/secure.config:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://gerrit/secure.config
    - template: jinja
    - require:
      - file: /var/lib/gerrit2/review_site/etc

/mnt/git:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - user: gerrit2

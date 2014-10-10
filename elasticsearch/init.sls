# Based on https://github.com/ConsumerAffairs/salt-states/blob/master/elasticsearch.sls

openjdk-7-jre-headless:
  pkg.installed

elasticsearch:
  pkg.installed:
    - sources:
      - elasticsearch: https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.deb
  service.running:
    - name: elasticsearch
    - running: True
    - enable: True
    - require:
      - pkg: elasticsearch
    - watch:
      - file: /etc/elasticsearch/elasticsearch.yml
      - file: /etc/default/elasticsearch


/etc/elasticsearch/elasticsearch.yml:
  file.exists:
    - require:
      - pkg: elasticsearch
#  file.managed:
#    - source: salt://elasticsearch/files/etc/elasticsearch/elasticsearch.yml.jinja
#    - template: jinja
#    - user: elasticsearch
#    - group: elasticsearch
#    - mode: 664
#    - required:
#      - pkg: elasticsearch


/etc/default/elasticsearch:
  file.exists:
    - require:
      - pkg: elasticsearch
#  file.managed:
#    - source: salt://elasticsearch/files/etc/default/elasticsearch.jinja
#    - template: jinja
#    - required:
#      - pkg: elasticsearch
#

/etc/elasticsearch/logging.yml:
  file.exists:
    - require:
      - pkg: elasticsearch
#  file.managed:
#    - source: salt://etc/elasticsearch/logging.yml.jinja
#    - template: jinja
#    - user: elasticsearch
#    - group: elasticsearch
#    - mode: 664
#    - required:
#      - pkg: elasticsearch


/usr/share/elasticsearch/data:
  file.directory:
    - user: elasticsearch
    - group: elasticsearch
    - mode: 755
    - makedirs: True
    - required:
      - pkg: elasticsearch

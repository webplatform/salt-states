{#
 # ElasticSearch configuration
 #
 # Loosely based on ConsumerAffairs Chef ElasticSearch recipe
 #
 # === MEMORY
 #
 # Maximum amount of memory to use is automatically computed as one half of total available memory on the machine.
 # You may choose to set it in your node/role configuration instead.
 #
 # ----
 #
 # See awesome Chef recipe:
 #   - https://github.com/ConsumerAffairs/salt-states/blob/master/elasticsearch.sls
 #   - https://github.com/elasticsearch/cookbook-elasticsearch/blob/master/attributes/default.rb
 #   - https://github.com/elasticsearch/cookbook-elasticsearch/blob/master/templates/default/elasticsearch.monitrc.conf.erb
 #
 # Ref:
 #   - http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup-service.html
 #   - http://www.xmsxmx.com/elasticsearch-cluster-configuration-best-practices/
 #
 # #TODO: Set minimum value ES_HEAP_SIZE=64m in /etc/defaults/elasticsearch
 # #TODO: To use ElasticSearchi (Cirrus Search), we have to add `script.disable_dynamic: false` in elasticsearch.yml
 #}
{%- set mem_int = grains['mem_total'] -%}
{%- set mem_calc = (mem_int * 0.6)/1024 -%}
{%- set allocated_memory = mem_calc|int ~ 'm' -%}

include:
  - mmonit

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

#ES_HEAP_SIZE=64m #TODO
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
  file.exists
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


/etc/monit/conf.d/elasticsearch.conf:
  file.managed:
    - source: salt://elasticsearch/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interfaces: {{ salt['grains.get']('ip4_interfaces:eth0') }}
        elastic_port: 9200
    - require:
      - service: elasticsearch
    - watch_in:
      - service: monit

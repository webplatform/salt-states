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
 # See awesome formulas/recipes:
 #   - https://github.com/ConsumerAffairs/salt-states/blob/master/elasticsearch.sls
 #   - https://github.com/elasticsearch/cookbook-elasticsearch/blob/master/attributes/default.rb
 #   - https://github.com/elasticsearch/cookbook-elasticsearch/blob/master/templates/default/elasticsearch.monitrc.conf.erb
 #
 # MediaWiki and ElasticSearch?
 #   - Not possible (for now) unless we open up security breach "dynamic scripting" (link below)
 #   - https://www.mediawiki.org/wiki/Thread:Extension_talk:CirrusSearch/Is_it_possible_for_CirrusSearch_to_NOT_require_dynamic_scripting%3F
 #   - https://git.wikimedia.org/blob/operations%2Fpuppet/production/modules%2Felasticsearch%2Ftemplates%2Felasticsearch.yml.erb#L469
 #
 # #TODO: Set minimum value ES_HEAP_SIZE=64m in /etc/defaults/elasticsearch
 # #TODO: To use ElasticSearchi (Cirrus Search), we have to add `script.disable_dynamic: false` in elasticsearch.yml
 #}
{%- set elasticsearch_folders = ['/usr/share/elasticsearch/data', '/tmp/elasticsearch', '/var/lib/elasticsearch'] -%}
{%- set mem_int = grains['mem_total'] -%}
{%- set mem_calc = (mem_int * 0.6)/1024 -%}
{%- set allocated_memory = mem_calc|int ~ 'm' -%}

include:
  - mmonit

openjdk-7-jre-headless:
  pkg.installed

#chown -R dhc-user:dhc-user /usr/share/elasticsearch/data
#chown -R dhc-user:dhc-user /tmp/elasticsearch
#chown -R dhc-user:dhc-user /tmp/hsperfdata_elasticsearch
#chown -R dhc-user:dhc-user /var/lib/elasticsearch
#find / -type d -group elasticsearch -exec chown dhc-user:dhc-user {} \; 2>/dev/null

elasticsearch:
  pkgrepo.managed:
    - name: deb http://packages.elasticsearch.org/elasticsearch/1.6/debian stable main
    - key_url: https://packages.elasticsearch.org/GPG-KEY-elasticsearch
  pkg.installed:
    - version: 1.6.0
  service.running:
    - running: True
    - enable: True
    - require:
      - pkg: elasticsearch
    - watch:
      - file: /etc/elasticsearch/elasticsearch.yml
      - file: /etc/default/elasticsearch

python-elasticsearch:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: elasticsearch

#ES_HEAP_SIZE=64m #TODO, in /etc/default/elasticsearch?
/etc/elasticsearch/elasticsearch.yml:
  file.exists

/etc/default/elasticsearch:
  file.append:
    - name: /etc/default/elasticsearch
    - text: |
        ES_USER=dhc-user
        ES_GROUP=dhc-user

/var/run/elasticsearch:
  file.directory:
    - createdirs: True

{% for es_folder in elasticsearch_folders %}
chown -R dhc-user:dhc-user {{ es_folder }}:
  cmd.run:
    - onlyif: "test `stat -c %G {{ es_folder }}` != dhc-user"
    - require:
      - pkg: elasticsearch
{% endfor %}

/etc/elasticsearch/logging.yml:
  file.exists

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


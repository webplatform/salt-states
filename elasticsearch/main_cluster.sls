include:
  - elasticsearch

elasticsearch-cluster-config-webplatform:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - contents: |
        node.fqdn: {{ grains['fqdn'] }}
        node.name: {{ grains['nodename'] }}
        cluster.name: webplatform
    - require:
      - pkg: elasticsearch

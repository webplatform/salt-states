include:
  - elasticsearch

Give a hint of the nodename:
  file.append:
    - name: /etc/elasticsearch/elasticsearch.yml
    - text: |
        node.fqdn: {{ grains['fqdn'] }}
        node.name: {{ grains['nodename'] }}
        cluster.name: wiki
    - require:
      - pkg: elasticsearch

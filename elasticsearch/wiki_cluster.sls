include:
  - elasticsearch

elasticsearch-cluster-config-wiki:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - contents: |
        node.fqdn: {{ grains['fqdn'] }}
        node.name: {{ grains['nodename'] }}
        cluster.name: wiki
        script.disable_dynamic: false
    - require:
      - pkg: elasticsearch


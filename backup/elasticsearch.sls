#
# What is required to make elasticsearch backups
#
# The following should mimick what an elastic node has for its system user.
# Since elasticsearch requires that all nodes to have same mountpoint for "fs" type snapshots,
# we also must have backup to have same user credentials as the elastic nodes.
#
{%- set nfs_mountpoint = salt['pillar.get']('infra:elasticsearch:backup_nfs_mountpoint', '/srv/exports/elasticsearch/foo') -%}
{%- set host = salt['pillar.get']('infra:elasticsearch:private', 'elasticsearch') -%}
{%- set port = salt['pillar.get']('infra:elasticsearch:port', 9200) -%}
{%- set level = salt['grains.get']('level', 'production') %}
#

{{ nfs_mountpoint }}:
  file.directory:
    - user: dhc-user
    - group: dhc-user
    - makedirs: True
    - dir_mode: 755
    - file_mode: 664
    - recurse:
        - user
        - group
        - mode

/usr/local/sbin/elasticsearch.sh:
  file.managed:
    - source: salt://backup/files/elasticsearch.sh.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 555
    - context:
        elasticsearch_nfs: {{ nfs_mountpoint }}
    - require:
      - file: {{ nfs_mountpoint }}

Create ElasticSearch backup cronjob:
  cron.present:
    - identifier: elasticsearch-backup
    - user: root
    - minute: 1
    - hour: 1
    - name: "JOBNAME=elasticsearch-backup cronhelper.sh /usr/local/sbin/elasticsearch.sh"
    - require:
      - file: /mnt/backup
      - file: /usr/local/sbin/elasticsearch.sh

Create ElasticSearch snapshot:
  cron.present:
    - identifier: elasticsearch-snapshot
    - user: root
    - hour: 0
    - name: "JOBNAME=elasticsearch-snapshot cronhelper.sh curl -XPUT http://{{ host }}:{{ port }}/_snapshot/nfsshared/{{ level }}?wait_for_completion=true"
  pkg.installed:
    - name: curl


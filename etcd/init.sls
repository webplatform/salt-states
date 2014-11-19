{%- set etcd = salt['pillar.get']('accounts:etcd') -%}
{%- set discovery = salt['pillar.get']('salt_cluster:discovery', 'https://discovery.etcd.io/6887ce87d17aa32e97412a70382e6091') -%}
{%- set data_dir = "/var/lib/etcd/" ~ grains['fqdn']|replace('.','_') -%}
{%- set etcd_user = 'nobody' -%}
{%- set etcd_group = 'www-data' -%}

include:
  - code.packages
  - mmonit

etcd:
  pkg.installed:
    - name: etcd
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/etcd/etcd.conf
    - require:
      - file: /etc/init/etcd.conf

/etc/etcd:
  file.directory:
    - makedirs: True

/etc/etcd/etcd.conf:
  file.managed:
    - source: salt://etcd/files/etcd.conf.jinja
    - template: jinja
    - context:
        data_dir: {{ data_dir }}
        nodename: {{ grains['fqdn'] }}
        discovery: {{ discovery }}
        addr: {{ grains['ipaddr'] }} 
    - require:
      - file: /etc/etcd
      - pkg: etcd

{{ data_dir }}:
  file.directory:
    - makedirs: True
    - user: {{ etcd_user }}
    - group: {{ etcd_group }}

/etc/init/etcd.conf:
  file.managed:
    - source: salt://etcd/files/upstart.conf.jinja
    - template: jinja
    - context:
        etcd_user: {{ etcd_user }}
        etcd_group: {{ etcd_group }}
        data_dir: {{ data_dir }}
    - require:
      - pkg: etcd
      - file: /etc/etcd/etcd.conf

/etc/monit/conf.d/etcd.conf:
  file.managed:
    - source: salt://etcd/files/monit.conf
    - require:
      - service: monit

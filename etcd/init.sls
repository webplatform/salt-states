{%- set etcd = salt['pillar.get']('accounts:etcd') -%}
{%- set data_dir = "/var/lib/etcd/" ~ grains['fqdn']|replace('.','_') -%}
{%- set etcd_user = 'nobody' -%}
{%- set etcd_group = 'www-data' -%}

include:
  - code.packages

etcd-package:
  pkg.installed:
    - name: etcd
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/webplatform.list

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
        discovery: {{ etcd.discovery|default('https://discovery.etcd.io/6887ce87d17aa32e97412a70382e6091') }}
        addr: {{ grains['ipaddr'] }} 
    - require:
      - file: /etc/etcd
      - pkg: etcd-package

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
      - pkg: etcd-package
      - file: /etc/etcd/etcd.conf

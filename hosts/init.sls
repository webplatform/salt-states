/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444

blockreplace-in-hosts:
  file.blockreplace:
    - name: /etc/hosts
    - marker_start: "# START managed hosts -DO-NOT-EDIT---"
    - marker_end: "# END managed hosts"
    - append_if_not_found: True

hosts-add-db-master:
  file.accumulated:
    - filename: /etc/hosts
    - name: hosts-accumulator
    - require_in:
      - file: blockreplace-in-hosts
    - text: |
        {{ salt['pillar.get']('infra:db:master:private') }}	{{ salt['pillar.get']('infra:db:master:hostname') }}

{% set h = salt['grains.get']('id') %}
{% if h == 'deployment' or h == 'monitor'  %}
adjust-hosts-deployment:
  file.accumulated:
    - filename: /etc/hosts
    - name: hosts-accumulator
    - require_in:
      - file: blockreplace-in-hosts
    - text: |
        10.0.0.1        controller.dho.wpdn
        10.0.0.17       compute2.dho.wpdn
        10.0.0.26       compute3.dho.wpdn
        10.0.0.15       compute1.dho.wpdn
        208.113.157.157 controller
        208.113.157.158 compute1
        208.113.157.159 compute2
        208.113.157.160 compute3
{% endif %}

{% if h == 'storage2' %}
append-for-storage2:
  file.append:
    - name: /etc/hosts
    - text: |
        127.0.0.1       storage2.dho.wpdn storage2.webplatform.org storage2
    - requires:
      - file: /etc/hosts

comment-storage1:
  file.comment:
    - name: /etc/hosts
    - regex: ^{{ salt['pillar.get']('infra:storage:master:private') }}(.*)storage2
    - requires:
      - file: append-to-hosts
      - file: /etc/hosts
{% endif %}

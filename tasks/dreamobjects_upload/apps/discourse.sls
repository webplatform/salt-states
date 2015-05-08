{%- set endpoint = salt['pillar.get']('accounts:swift:dreamhost:endpoint') -%}
{%- set key = salt['pillar.get']('dreamobjects:discourse:key', 'missing_key') -%}
{%- set secret = salt['pillar.get']('dreamobjects:discourse:secret', 'missing_secret') -%}
{%- set bucket = salt['pillar.get']('dreamobjects:discourse:bucket', 'missing_bucket') -%}
{%- set dir = salt['pillar.get']('dreamobjects:discourse:dir', 'missing_dir') -%}

/usr/local/sbin/dreamobjects_uploader.sh:
  cmd.wait:
    - onlyif: test -d {{ dir }}
    - cwd: {{ dir }}
    - stateful: True
    - env:
      - 'ST_KEY': '{{ secret }}'
      - 'ST_USER': '{{ key }}'
      - 'ST_AUTH': '{{ endpoint }}'
      - 'SYNC_DIR': '{{ dir }}'
      - 'SYNC_BUCKET': '{{ bucket }}'


{%- set level = salt['grains.get']('level', 'production') -%}

include:
  - code.prereq
  - rsync.secret

/etc/ssl/webplatform:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: www-data

# @salt-master-dest
certificates-rsync:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/packages/certificates/{{ level }}/ /etc/ssl/webplatform/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
  file.directory:
    - name: /etc/ssl/webplatform
    - user: www-data
    - group: www-data
    - mode: 640
    - recurse:
      - user
      - group
      - mode


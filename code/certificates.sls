include:
  - rsync.secret
  - code.prereq

certificates-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/certificates/staging/ /etc/ssl/webplatform/"
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

/etc/ssl/webplatform:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: www-data
    - require:
      - cmd: certificates-rsync

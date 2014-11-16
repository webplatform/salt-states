include:
  - rsync.secret
  - code.prereq

/etc/apt/sources.list.d/webplatform.list:
  file.managed:
    - contents: |
        # Managed by Salt Stack at salt/webplatform/init.sls
        deb file:/srv/webplatform/packages/apt ./

packages-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt.local.wpdn::code/packages/ /srv/webplatform/packages/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

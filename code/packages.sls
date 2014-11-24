include:
  - rsync.secret
  - code.prereq

/etc/apt/sources.list.d/webplatform.list:
  file.managed:
    - contents: |
        # Managed by Salt Stack at salt/webplatform/init.sls
        deb file:/srv/webplatform/apt ./
        # See also http://wpd-packages.objects.dreamhost.com/apt #TODO

# @salt-master-dest
packages-rsync:
  cmd:
    - run
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/packages/apt/ /srv/webplatform/apt/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

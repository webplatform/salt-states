include:
  - code.prereq
  - rsync.secret

/etc/apt/sources.list.d/webplatform.list:
  file.managed:
    - contents: |
        # Managed by Salt Stack at salt/webplatform/init.sls
        deb file:/srv/webplatform/apt ./
        # try also:
        #   apt-get update -o Debug::Acquire::http=true 2> log.txt
        #
        # #TODO; Ideally it should be on a remote HTTP server, on DreamObjects, behind Fastly.
        # I Couldnt make it work so far, once it works, remove /srv/salt/code/packages.sls and
        # move this statement in /srv/salt/webplatform/init.sls instead of using wpd-deploy method.
        #
        # Could eventually replace webplatform.list line as:
        #   deb http://apt.webplatform.org/ubuntu webplatform/
        #   deb http://apt.webplatform.org/ubuntu/webplatform ./
    - require:
      - cmd: packages-rsync

# @salt-master-dest
packages-rsync:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/packages/apt/ /srv/webplatform/apt/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

rsync-error-documents:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/errors/ /srv/webplatform/errors/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

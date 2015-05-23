include:
  - code.prereq
  - rsync.secret

rsync-error-documents:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/errors/ /srv/webplatform/errors/"
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

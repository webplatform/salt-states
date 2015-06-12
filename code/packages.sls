include:
  - code.prereq
  - rsync.secret

rsync from salt static error pages in /srv/code/www/repo/out/errors:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/errors/ /srv/webplatform/errors/"
    ## We could prevent errors here, but its useful to be reminded that we need to compile the static homepage
    #- onlyif: test -d /srv/code/www/repo/out/errors
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

include:
  - rsync.secret
  - code.prereq
  - cron

# @salt-master-dest
sync-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@salt::code/accounts/dists/ /srv/webplatform/auth/dists/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/auth/dists
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/auth/dists
    - user: renoirb
    - group: deployment
    - makedirs: True
    - recurse:
      - user
      - group


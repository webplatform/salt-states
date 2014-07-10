include:
  - rsync.secret
  - code.prereq
  - cron

sync-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@deployment.dho.wpdn::code/accounts/dists/ /srv/webplatform/auth/dists/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/auth/dists
  file.directory:
    - name: /srv/webplatform/auth/dists
    - user: renoirb
    - group: deployment
    - makedirs: True
    - recurse:
      - user
      - group

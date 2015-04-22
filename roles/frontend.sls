# What we expose to the public, to proxy the upstream nodes
include:
  - rsync.secret
  - code.prereq
  - code.certificates

# We’ll have to cleanup the code.www sls eventually #TODO
# @salt-master-dest
Superseed default NGINX documents:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/errors/ /var/www/html/"
    - require:
      - file: /etc/codesync.secret


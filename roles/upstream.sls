# Represents an internal only server
# Eventually we would refactor roles.app, roles.blog, roles.project to be exposed through

include:
  - rsync.secret

# Cleanup this one, roles.upstream and roles.www #TODO
# @salt-master-dest
Superseed default /var/www/html documents:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/errors/ /var/www/html/"
    - require:
      - file: /etc/codesync.secret

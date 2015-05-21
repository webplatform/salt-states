# Role we use to expose internal upstream service to the public
# This role has been created to expose services as described
# in https://github.com/webplatform/ops/issues/115

include:
  - rsync.secret
  - code.certificates
  # It has been planned to have no static site on frontend, this should move into a -upstream VM.
  # Maybe we should create a "static" upstream node very soon. We could put the www site on it too #TODO
  - code.webat25

# Cleanup this one, roles.upstream and roles.www #TODO
# @salt-master-dest
Superseed default /var/www/html documents:
  cmd.run:
    - name: "rsync -a --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/www/repo/out/errors/ /var/www/html/"
    - require:
      - file: /etc/codesync.secret


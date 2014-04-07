include:
  - ssl
  - sslproxy.nginx

redis-server:
  pkg.installed

oauthd-bleeding-requirements:
  cmd.run:
    - name: npm install -g coffee-script grunt-cli forever
    - unless: test -d /usr/lib/node_modules/grunt-cli
    # Reminder, to test folder existence: test -d /usr/lib && echo 'Folder exist' || echo 'Folder doesnt'

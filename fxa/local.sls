include:
  - .
  - nginx.local
  - .frontend

# The ^ .frontend here is a special case, for now we’ll reuse the **same** vhosts
# other "local" states shouldn’t do this.

extend:
  /etc/nginx/sites-available/accounts:
    file.managed:
      - contents: |
          # Managed by Salt Stack, do NOT edit manually!
          # Since Hypothes.is uses Python 2.6 and has problems with SSL certificates
          # We need to have the accounts upstream server to only serve those vhosts


# In the case of FxA, we’ll reuse the **same** vhosts

include:
  - .
  - nginx.local
  - .nginx

extend:
  /etc/nginx/sites-available/accounts:
    file.managed:
      - contents: |
          # Managed by Salt Stack, do NOT edit manually!
          # Since Hypothes.is uses Python 2.6 and has problems with SSL certificates
          # We need to have the accounts upstream server to only serve those vhosts


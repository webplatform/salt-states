include:
  - nodejs

/srv/.npm:
  file.directory:
    - group: users
    - user: nobody

/usr/lib/node_modules/npm/npmrc:
  file.managed:
    - contents: |
        tmp = /srv/.npm/tmp
        cache = /srv/.npm/cache